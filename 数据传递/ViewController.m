//
//  ViewController.m
//  数据传递
//
//  Created by love on 2017/4/21.
//  Copyright © 2017年 guanal. All rights reserved.
//

#import "ViewController.h"

#import "BViewController.h"

#import "CViewController.h"

#import "DViewController.h"

#import "locatonViewController.h"

#import <AVFoundation/AVFoundation.h>
#import "NSString+EMOEmoji.h"

#import "modleView.h"
#import "UIView+Layout.h"
#import "SnailPopupController.h"

#define random(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)/255.0]

#define randomColor random(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256))

@interface ViewController ()<BViewControllerDelegate>

/**
 需要传递的参数
 */
@property (nonatomic , strong) NSString * userStr;

/**
 跳转数组
 */
@property (nonatomic , strong) NSArray * titleArray;


// 声明音乐播放控件，必须声明为全局属性变量，否则可能不会播放，AVAudioPlayer 只能播放本地音乐
@property(nonatomic, retain)AVAudioPlayer *musicPlayer;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"首页";

    self.userStr = @"今天天气不错";
    
    [self.userStr emo_containsEmoji];
    
    self.titleArray = @[@"参数传值",@"block传值",@"加载HTML",@"弹出框",@"定位"];
    
    [self creatUI];
    // Do any additional setup after loading the view, typically from a nib.
    
}

-(void)viewWillAppear:(BOOL)animated
{
    self.view.backgroundColor = randomColor;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(gnotification:) name:@"NSNotificationTitle" object:nil];
    
    int a = arc4random()%4;
    NSLog(@"随机数---%d",a);
    if (a == 0) {
        //添加1/4崩溃几率
//        exit(2);
    }

    
}




-(void)creatUI{
    
    
    for (NSInteger i = 0; i < self.titleArray.count ; i++) {
        
        UIButton * button = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 120, 40)];
        
        button.center = CGPointMake(self.view.center.x, 120 +(i * 60));
        
        button.backgroundColor = randomColor;
        
        button.tag = i + 1; 
        
        [button setTitle:self.titleArray[i] forState:UIControlStateNormal];
        
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.view addSubview:button];
        
        
    }
    
    
    
}


-(void)buttonClick:(UIButton *)sender{
    
    NSLog(@"点击了第%ld个",(long)sender.tag);
    
    switch (sender.tag) {
        case 1:
        {
            BViewController * bView = [[BViewController alloc]init];
            
            bView.recText = self.userStr;
            
            bView.delegate = self;
            
            [self.navigationController pushViewController:bView animated:YES];
        }
            
            break;
        case 2:
        {
            CViewController * cView = [[CViewController alloc]init];
            
             //赋值Block，并将捕获的值赋值给UILabel
            cView.returnValueBlock = ^(NSString *strValue) {

                self.title = strValue;
                
            };
            
            [self.navigationController pushViewController:cView animated:YES];
        }
            
            break;
        case 3:
        {
            DViewController * bView = [[DViewController alloc]init];
            
            [self.navigationController pushViewController:bView animated:YES];
        }
            
            break;
        case 4:
        {
            NSLog(@"弹出右滑视图");
            modleView *sidebar = [self sidebarView];
            
            sidebar.closeClicked = ^(UIButton *closeButton) {
                [self.sl_popupController dismissWithDuration:0.25 elasticAnimated:NO];
            };
            
            self.sl_popupController = [SnailPopupController new];
            self.sl_popupController.layoutType = PopupLayoutTypeLeft;
            self.sl_popupController.allowPan = YES;
            [self.sl_popupController presentContentView:sidebar];
        }
            
            break;
        case 5:
        {
            NSLog(@"定位");
            locatonViewController * LVC = [[locatonViewController alloc]init];
            [self.navigationController pushViewController:LVC animated:YES];
            
        }
            break;

            
        default:
            break;
    }
}


- (modleView *)sidebarView {
    
    modleView *sidebarView = [modleView new];
    NSLog(@"X--%f，Y--%f",[[UIScreen mainScreen] bounds].size.width,[[UIScreen mainScreen] bounds].size.height);
    sidebarView.size = CGSizeMake(375, 375);
    sidebarView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    sidebarView.models = @[@"我的故事", @"消息中心", @"我的收藏", @"近期阅读", @"离线阅读"];
    return sidebarView;
}


-(void)bViewController:(BViewController *)bVC clickBtnReturn:(NSString *)message
{
    self.title = message;
}

-(void)gnotification:(NSNotification *)note{
    
    NSString * string = note.object;
    
    self.title = string;
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

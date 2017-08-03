//
//  BViewController.m
//  数据传递
//
//  Created by love on 2017/4/21.
//  Copyright © 2017年 guanal. All rights reserved.
//

#import "BViewController.h"

#import "ViewController.h"

//#import <SDWebImage/UIImage+GIF.h>
//#import "FLAnimatedImageView+WebCache.h"
#import "FLAnimatedImageView.h"
#import "FLAnimatedImage.h"

#define IMScreenHeight  [[UIScreen mainScreen] bounds].size.height
#define IMScreenWidth  [[UIScreen mainScreen] bounds].size.width

@interface BViewController ()

@property (nonatomic, strong) FLAnimatedImageView *gitImgV;
@property (nonatomic, strong) UIImageView * imgV;

@end

@implementation BViewController

#pragma mark - LifeCycle

-(void)viewWillAppear:(BOOL)animated
{
    if (self) {
        
//        self.navigationController.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObject:[UIColor greenColor] forKey:NSForegroundColorAttributeName];
        
        
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStyleDone target: self action:@selector(back)];
        
        UIBarButtonItem * push = [[UIBarButtonItem alloc]initWithTitle:@"跳转" style:UIBarButtonItemStylePlain target:self action:@selector(push)];
        
        UIBarButtonItem * log = [[UIBarButtonItem alloc]initWithTitle:@"代理传值" style:UIBarButtonItemStylePlain target:self action:@selector(log)];
        
        NSArray * arr = [NSArray arrayWithObjects:push,log, nil];
        
        self.navigationItem.rightBarButtonItems = arr;
    }

}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = self.recText;
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    [self addgifImage];
    
    
}

-(void)addgifImage{
    
    self.gitImgV = [[FLAnimatedImageView alloc]initWithFrame:CGRectMake(0, 0, 200, 200)];
    self.gitImgV.center = self.view.center;
    self.gitImgV.backgroundColor = [UIColor grayColor];
    [self.view addSubview:self.gitImgV];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"777" ofType:@"gif"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    
    self.gitImgV.animatedImage = [FLAnimatedImage animatedImageWithGIFData:data];
    
    [self.gitImgV stopAnimating];
//    self.gitImgV.image = image;
    
    self.gitImgV.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *doubleTapGestureRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(doubleTap:)];
     [doubleTapGestureRecognizer setNumberOfTapsRequired:1];
    [self.gitImgV addGestureRecognizer:doubleTapGestureRecognizer];

    
}


-(void)doubleTap:(UIGestureRecognizer *)recognizer{
    NSLog(@"点击");
//    if (self.gitImgV.isAnimating) {
//        NSLog(@"停");
//         [self.gitImgV stopAnimating];
//    }else
//    {
//        NSLog(@"动");
//         [self.gitImgV startAnimating];
//    }
    
    self.gitImgV.isAnimating? [self.gitImgV stopAnimating]:[self.gitImgV startAnimating];
    
}

#pragma mark - UITableViewDelegate

-(void)back{
    
    [self.navigationController popViewControllerAnimated:YES];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"NSNotificationTitle" object:@"通知的title"];
    
    
}


-(void)push{
    
    UIViewController * viewC = [[UIViewController alloc]init];
    
    [self.navigationController pushViewController:viewC animated:NO];
    
}

-(void)log{
    NSLog(@"111");
    [self.delegate bViewController:self clickBtnReturn:@"代理传值返回"];

    [self.navigationController popViewControllerAnimated:YES];
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"NSNotificationTitle" object:nil];
    NSLog(@"通知销毁了");
}

@end


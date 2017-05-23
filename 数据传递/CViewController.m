//
//  CViewController.m
//  数据传递
//
//  Created by love on 2017/5/2.
//  Copyright © 2017年 guanal. All rights reserved.
//

#import "CViewController.h"



#define IMScreenHeight  [[UIScreen mainScreen] bounds].size.height
#define IMScreenWidth  [[UIScreen mainScreen] bounds].size.width

#define random(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)/255.0]

#define randomColor random(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256))


@interface CViewController ()<UITextFieldDelegate>

@property (nonatomic, strong) UITextField * textField;



@end

@implementation CViewController

#pragma mark - LifeCycle

- (void)viewDidLoad
{
    self.view.backgroundColor = [UIColor whiteColor];
    [super viewDidLoad];
    [self setUpUI];
    
}

-(void)setUpUI{
    
    UITextField *textF = [[UITextField alloc]initWithFrame:CGRectMake(0, 40, IMScreenWidth, 50)];
    
//    textF.center = self.view.center;
    textF.backgroundColor = randomColor;
    
    textF.textAlignment = NSTextAlignmentCenter;
    
    textF.placeholder = @" 传值";
    
    textF.delegate = self;
    
    self.textField = textF;
    
    
    UIButton * button = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 120, 40)];
    
    button.center = CGPointMake(self.view.center.x, self.view.center.y - 100);
    
    button.backgroundColor = randomColor;
 
    
    [button setTitle:@"返回" forState:UIControlStateNormal];
    
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:button];

    [self.view addSubview:self.textField];
    
}

-(void)buttonClick:(UIButton *)sender{

    NSString * str = self.textField.text;
    
    if (self.returnValueBlock) {
        self.returnValueBlock(str);
    }
    
    [self.navigationController popViewControllerAnimated:YES];
    
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.textField resignFirstResponder];
}

-(void)dealloc
{
    NSLog(@"Block页面_销毁了");
}

#pragma mark - Public

#pragma mark - Private

#pragma mark - Getter

#pragma mark - Setter

@end


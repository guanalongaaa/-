//
//  BViewController.m
//  数据传递
//
//  Created by love on 2017/4/21.
//  Copyright © 2017年 guanal. All rights reserved.
//

#import "BViewController.h"

#import "ViewController.h"

#define IMScreenHeight  [[UIScreen mainScreen] bounds].size.height
#define IMScreenWidth  [[UIScreen mainScreen] bounds].size.width

@interface BViewController ()

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


//
//  DViewController.m
//  数据传递
//
//  Created by love on 2017/5/16.
//  Copyright © 2017年 guanal. All rights reserved.
//

#import "DViewController.h"

#import "GoComUrlProtocol.h"

#import <JavaScriptCore/JavaScriptCore.h>


#define IMScreenHeight  [[UIScreen mainScreen] bounds].size.height
#define IMScreenWidth  [[UIScreen mainScreen] bounds].size.width

@interface DViewController ()<UIWebViewDelegate>

@property (nonatomic,retain) UIWebView *myWebView;


@end

@implementation DViewController

#pragma mark - LifeCycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.myWebView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, IMScreenWidth, IMScreenHeight)];
    [self.view addSubview:self.myWebView];
    
//    NSURL *url = [NSURL URLWithString:@"http://47.93.34.13:9901/Receipt/rp/creatReceipt.html?token=093b7acc65f12a4d119403ec3de258d1"];
    
    self.myWebView.delegate=self;
    NSString *path = [[NSBundle mainBundle] pathForResource:@"simple" ofType:@"html"];
    [_myWebView loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath: path]]];
    
//    [self.myWebView loadRequest:[NSURLRequest requestWithURL:url]];
    
    //http://47.93.34.13:9901/Receipt/rp/creatReceipt.html?token=093b7acc65f12a4d119403ec3de258d1
    
    NSString * str = [NSString stringWithFormat:@"%@,%@",@"guanal",@"setup"];
    
    NSLog(@"%@", str);
    
    char *name = "itisgl";
    
    NSLog(@"%s",name);
    
}

-(void)viewWillAppear:(BOOL)animated{

    UIButton *closeBtn = [[UIButton alloc] initWithFrame:CGRectMake(30.0 *IMScreenWidth / 320.0, 6.0, 60.0, 32.0)];
    
    UIImage *img1 = [UIImage imageNamed:@"service_icon"];
    [closeBtn setImage:img1 forState:UIControlStateNormal];
    
//    [closeBtn setTitle:@"关闭" forState:UIControlStateNormal];
    [closeBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    closeBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [closeBtn addTarget:self action:@selector(navigationBack:) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationController.navigationBar addSubview:closeBtn];
    
    
    UIButton *customBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    customBtn.frame = CGRectMake(0, 0, 30, 30);
    UIImage *img = [UIImage imageNamed:@"jiantou_left"];
    [customBtn setImage:img forState:UIControlStateNormal];
    [customBtn addTarget:self action:@selector(goBack:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:customBtn];
    self.navigationItem.leftBarButtonItem = item;
}

-(void) goBack:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return YES;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewDidUnload {
    self.myWebView=nil;
}

#pragma mark –
#pragma mark UIWebViewDelegate
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    
//    NSString* urlStr = request.URL.absoluteString;
//    
//    
//    NSString *requestString = [[[request URL] absoluteString]stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//    NSLog(@"requestString : %@",requestString);
//    
//    
//    NSArray *components = [requestString componentsSeparatedByString:@"|"];
//    NSLog(@"=components=====%@",components);
//    
//    
//    NSString *str1 = [components objectAtIndex:0];
//    NSLog(@"str1:::%@",str1);
//    
//    
//    NSArray *array2 = [str1 componentsSeparatedByString:@"/"];
//    NSLog(@"array2:====%@",array2);
//    
//    
//    NSInteger coun = array2.count;
//    NSString *method = array2[coun-1];
//    NSLog(@"method:===%@",method);
//    
//    if ([method isEqualToString:@"demo.html"]){
//        
//    }
//    
    return YES;

}


//- (void)webViewDidStartLoad:(UIWebView *)webView
//{
//    NSString *title = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
//    NSLog(@"title11=%@",title);
//}
- (void)webViewDidFinishLoad:(UIWebView *)webView
{

    
    JSContext *context = [webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    
    context[@"loginaaa"] = ^(NSString * str){
        
        NSArray *args = [JSContext currentArguments];
        
        for ( JSValue *jsVsl in args) {
            
            NSLog(@"%@",jsVsl.toString);
        }
        
        
        
        
    };
    

}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{ 
}

#pragma mark - UITableViewDelegate

#pragma mark - Public

#pragma mark - Private

#pragma mark - Getter

#pragma mark - Setter

@end


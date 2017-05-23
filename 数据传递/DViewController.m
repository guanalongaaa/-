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
    
}

-(void)viewWillAppear:(BOOL)animated{

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


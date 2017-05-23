//
//  GoComUrlProtocol.m
//  GoComIM
//
//  Created by wangshuang on 14-4-2.
//  Copyright (c) 2014年 wangshuang@smartdot.com. All rights reserved.
//

#import "GoComUrlProtocol.h"
//#import "NSData+Base64.h"

@interface GoComHTTPURLResponse : NSHTTPURLResponse
@property (nonatomic) NSInteger statusCode;
@end
static DViewController* currentWebView;
NSString* const LOCAL_HTTP_SCHEME = @"local://gocom/";
NSString* const WWW_FOLDER_NAME = @"www";
BOOL registed = NO;

@implementation GoComUrlProtocol

+ (void)registerViewController:(DViewController*)viewController {
    if(!registed) {
        [NSURLProtocol registerClass:[GoComUrlProtocol class]];
    }
    currentWebView = viewController;
}

+ (void) unregisterViewController:(DViewController *)viewController {
    currentWebView = nil;
    [NSURLProtocol unregisterClass:[GoComUrlProtocol class]];
    registed = NO;
}

+ (BOOL)canInitWithRequest:(NSURLRequest*)theRequest
{
    NSURL* theUrl = [theRequest URL];
    //获取本地的资源文件，比如jquery mobile等
    if([[theUrl absoluteString] hasPrefix:LOCAL_HTTP_SCHEME] && ![[theUrl path] isEqualToString:@"chatUser.html"]) {
        return YES;
    } else if(currentWebView != nil) {
        //处理对应的gocom命令
        if([[theUrl path] isEqualToString:@"chatUser.html"]) {
            return YES;
        }
        return NO;
    }
    else if([[theUrl path] isEqualToString:@"/WebApp/sportsPunchAction_insertCurrentSportsUserInfo.action"]){
        return YES;
    }
    return NO;
}

+ (NSURLRequest*)canonicalRequestForRequest:(NSURLRequest*)request
{
    return request;
}


- (void)startLoading
{
    NSURL* url = [[self request] URL];
    if ([[url path] isEqualToString:@"chatUser.html"]) {
        //获取对应的命令，以及相关参数信息
        NSString* cmdName = [[self request] valueForHTTPHeaderField:@"cmd"];
        if(cmdName == nil || cmdName.length == 0) {
            return ;
        }
        NSString* argsData = [[self request] valueForHTTPHeaderField:@"args"];
        NSString* successCallback = [[self request] valueForHTTPHeaderField:@"success"];
        NSString* failCallback = [[self request] valueForHTTPHeaderField:@"fail"];
        //NSMutableDictionary *data = [NSMutableDictionary dictionaryWithObjectsAndKeys:cmdName,@"cmd",successCallback,@"success",failCallback,@"fail",nil];
        NSMutableDictionary *data = [NSMutableDictionary dictionary];
        [data setObject:cmdName forKey:@"cmd"];
        if (successCallback == nil) {
            
        }else{
            [data setObject:successCallback forKey:@"success"];
        }
        if (failCallback == nil) {
            
        }else{
            [data setObject:failCallback forKey:@"fail"];
        }

        if(argsData == nil || argsData.length == 0) {
            [data setObject:@"type:cmd}" forKey:@"args"];
        }else {
            NSData* decodedData = argsData;
            NSString* decodedArgs = [[NSString alloc] initWithData:decodedData encoding:NSUTF8StringEncoding];
            [data setObject:decodedArgs forKey:@"args"];
        }
        
        
        if([currentWebView respondsToSelector:@selector(runCommand:)])
        {
            [currentWebView performSelectorOnMainThread:@selector(runCommand:) withObject:data waitUntilDone:NO];
        }else {
        }
        [self sendResponseWithResponseCode:200 data:nil mimeType:nil];
        return;
    } else if ([[url absoluteString] hasPrefix:LOCAL_HTTP_SCHEME]) {
        NSURL* relativeURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] bundlePath]];
        NSString* pagePath = [[url absoluteString] substringFromIndex:LOCAL_HTTP_SCHEME.length];
        NSString* localURL = [NSString stringWithFormat:@"%@/%@", WWW_FOLDER_NAME, pagePath];
        NSMutableURLRequest *newRequest = [self.request mutableCopy];
        [newRequest setURL:[NSURL URLWithString:localURL relativeToURL:relativeURL]];
        self.connection = [NSURLConnection connectionWithRequest:newRequest delegate:self];
        return;
    }
}

- (void)sendResponseWithResponseCode:(NSInteger)statusCode data:(NSData*)data mimeType:(NSString*)mimeType
{
    if (mimeType == nil) {
        mimeType = @"text/plain";
    }
    NSString* encodingName = [@"text/plain" isEqualToString : mimeType] ? @"UTF-8" : nil;
    GoComHTTPURLResponse* response =
    [[GoComHTTPURLResponse alloc] initWithURL:[[self request] URL]
                                   MIMEType:mimeType
                      expectedContentLength:[data length]
                           textEncodingName:encodingName];
    response.statusCode = statusCode;
    
    [[self client] URLProtocol:self didReceiveResponse:response cacheStoragePolicy:NSURLCacheStorageNotAllowed];
    if (data != nil) {
        [[self client] URLProtocol:self didLoadData:data];
    }
    [[self client] URLProtocolDidFinishLoading:self];
}

- (void)stopLoading
{
    // do any cleanup here
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [[self client] URLProtocol:self didLoadData:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    [[self client] URLProtocol:self didFailWithError:error];
    self.connection = nil;
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    [[self client] URLProtocol:self didReceiveResponse:response cacheStoragePolicy:[[self request] cachePolicy]];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection  {
    [[self client] URLProtocolDidFinishLoading:self];
    self.connection = nil;
}
@end
@implementation GoComHTTPURLResponse
@synthesize statusCode;
@end

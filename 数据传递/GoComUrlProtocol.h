//
//  GoComUrlProtocol.h
//  GoComIM
//
//  Created by wangshuang on 14-4-2.
//  Copyright (c) 2014年 wangshuang@smartdot.com. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "DViewController.h"
@interface GoComUrlProtocol : NSURLProtocol
@property (nonatomic, strong) NSURLConnection *connection;
+ (void)registerViewController:(DViewController*)viewController;
+ (void)unregisterViewController:(DViewController*)viewController;
@end

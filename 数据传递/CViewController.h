//
//  CViewController.h
//  数据传递
//
//  Created by love on 2017/5/2.
//  Copyright © 2017年 guanal. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 类型定义
 */
typedef void (^returnValueBlock)(NSString *strValue);

@interface CViewController : UIViewController

/**
 声明一个returnValueBlock属性，这个Block是获取传值界面传进来的
 */
@property (nonatomic, copy) returnValueBlock returnValueBlock;

@end

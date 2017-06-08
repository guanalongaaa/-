//
//  BViewController.h
//  数据传递
//
//  Created by love on 2017/4/21.
//  Copyright © 2017年 guanal. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BViewController;

@protocol BViewControllerDelegate <NSObject>

-(void)bViewController:(BViewController *)bVC clickBtnReturn:(NSString *)message;
@end

@interface BViewController : UIViewController


/**
 参数接收
 */
@property (nonatomic , strong) NSString *recText;

/**
 设置代理
 */
@property (assign, nonatomic)id<BViewControllerDelegate> delegate;


@end

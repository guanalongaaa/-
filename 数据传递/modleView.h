//
//  modleView.h
//  数据传递
//
//  Created by love on 2017/6/5.
//  Copyright © 2017年 guanal. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface modleView : UIView

@property (nonatomic, strong) NSArray<NSString *> *models;
@property (nonatomic, strong, readonly) NSMutableArray<UILabel *> *items;
@property (nonatomic, copy) void (^closeClicked)(UIButton *closeButton);
@property (nonatomic, copy) void (^didClickItems)(modleView *sidebarView, NSInteger index);

@property (nonatomic, strong) UITableView * tableView;

@end

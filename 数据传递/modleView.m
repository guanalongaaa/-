//
//  modleView.m
//  数据传递
//
//  Created by love on 2017/6/5.
//  Copyright © 2017年 guanal. All rights reserved.
//

#import "modleView.h"

#define IMScreenHeight  [[UIScreen mainScreen] bounds].size.height
#define IMScreenWidth  [[UIScreen mainScreen] bounds].size.width

@interface modleView ()<UITableViewDelegate,UITableViewDataSource>


@property (nonatomic, strong) UILabel *nightItem;
@property (nonatomic, strong) UIButton * leftbtn;

@property (nonatomic, strong) NSMutableArray *contentArray;

@end

@implementation modleView

- (instancetype)init {
    if (self = [super init]) {

        _nightItem = [self itemWithText:@"会议控制" imageNamed:@"sidebar_NightMode"];
        [self addSubview:_nightItem];
        
        self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 80, IMScreenWidth,IMScreenHeight- 80) style:UITableViewStylePlain];
        self.tableView.backgroundColor = [UIColor greenColor];
        self.tableView.delegate=self;
        self.tableView.dataSource=self;
        self.tableView.tableFooterView=[[UIView alloc]init];
        self.tableView.rowHeight = 60;
        [self addSubview:self.tableView];

        self.contentArray = [NSMutableArray arrayWithObjects:@"1.",@"2.",@"3.",@"4.",@"5.",@"6.",@"7.",@"8.",@"9.", nil];
        
        
        self.leftbtn = [self btninitWithText:@"关闭" imageNamed:@"qzone_close.png"];
        
        [self addSubview:self.leftbtn];
    }
    return self;
}

-(UIButton *)btninitWithText:(NSString *)text imageNamed:(NSString *)imageNamed {
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 20, 80, 60);
//    button.backgroundColor = [UIColor greenColor];
    [button setTitle:text forState:UIControlStateNormal];
    [button addTarget:self action:@selector(closeClick:) forControlEvents:UIControlEventTouchUpInside];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    [button setImage:[UIImage imageNamed:imageNamed] forState:UIControlStateNormal];
    [button setImageEdgeInsets:UIEdgeInsetsMake(10, 10, 10, 30)];
//    [button setTitleEdgeInsets:UIEdgeInsetsMake(0, 30, 0, 0)];
    
    return button;
}

- (UILabel *)itemWithText:(NSString *)text imageNamed:(NSString *)imageNamed {
    UILabel *item = [UILabel new];
    
    NSLog(@"X--%f,Y--%f",self.center.x,self.center.y);
    
    item.frame = CGRectMake(100, 20, 100, 60);
//    item.center = self.center;
    item.textColor = [UIColor blackColor];
    item.textAlignment = NSTextAlignmentCenter;
    
    item.text = text;
    return item;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    NSLog(@"标签");
}


//- (void)setModels:(NSArray<NSString *> *)models {
//    _items = @[].mutableCopy;
//    CGFloat _gap = 15;
//    [models enumerateObjectsUsingBlock:^(NSString *text, NSUInteger idx, BOOL * _Nonnull stop) {
//        
//        UILabel *item = [[UILabel alloc] init];
//        item.font = [UIFont systemFontOfSize:15];
//        item.textColor = [UIColor blackColor];
//       
//        item.frame = CGRectMake(100, (_gap + 80)*idx + 100, 100, 100);
//        item.text = text;
//        
//        [self addSubview:item];
////        item.frame.size.height = _gap * idx + 150;
////        item.centerX = self.width / 2;
//        
//        [_items addObject:item];
//        item.tag = idx;
//        
////        [item addTarget:self action:@selector(itemClicked:) forControlEvents:UIControlEventTouchUpInside];
//    }];
//}

#pragma mark  UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.contentArray.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
//    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"topCell"];
    
//   UITableViewCell * cell =[[[NSBundle mainBundle]loadNibNamed:@"nil" owner:nil options:nil]firstObject];
    
    static NSString *CellIdentifier = @"ContactCellID";
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        
    }

    
    cell.backgroundColor = [UIColor yellowColor];
    cell.accessoryType = UITableViewCellAccessoryNone;
    NSString * dic = self.contentArray[indexPath.row];
    cell.textLabel.text = dic;
    return cell;
}

#pragma mark - cell点击事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    //加入会议
    NSLog(@"%ld",(long)indexPath.row);

}



- (void)itemClicked:(UIButton *)sender {
    if (nil != self.didClickItems) {
        self.didClickItems(self, sender.tag);
    }
}

-(void)closeClick:(UIButton *)sender{
    
    if (nil != self.closeClicked) {
        self.closeClicked(sender);
    }

}

@end

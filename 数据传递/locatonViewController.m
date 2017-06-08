//
//  locatonViewController.m
//  数据传递
//
//  Created by love on 2017/6/8.
//  Copyright © 2017年 guanal. All rights reserved.
//

#import "locatonViewController.h"
#import "AFNetworking.h"
//#import "AFNetworking/AFNetworking.h"

#define DefaultLocationTimeout 10
#define DefaultReGeocodeTimeout 5

@interface locatonViewController ()<AMapLocationManagerDelegate>

@property (nonatomic, copy) AMapLocatingCompletionBlock completionBlock;

@property (nonatomic, strong) UILabel *displayLabel;

@property (nonatomic, strong) NSString * latitude;
@property (nonatomic, strong) NSString * longitude;

@end

@implementation locatonViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    [self initToolBar];
    
    [self initNavigationBar];
    
    [self initCompleteBlock];
    
    [self configLocationManager];
    
    [self initDisplayLabel];
    
    // Do any additional setup after loading the view.
}

- (void)initToolBar
{
//    UIBarButtonItem *flexble = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
//                                                                             target:nil
//                                                                             action:nil];
//    
//    UIBarButtonItem *reGeocodeItem = [[UIBarButtonItem alloc] initWithTitle:@"带逆地理定位"
//                                                                      style:UIBarButtonItemStylePlain
//                                                                     target:self
//                                                                     action:@selector(reGeocodeAction)];
//    
//    UIBarButtonItem *locItem = [[UIBarButtonItem alloc] initWithTitle:@"不带逆地理定位"
//                                                                style:UIBarButtonItemStylePlain
//                                                               target:self
//                                                               action:@selector(locAction)];
//    
//    self.toolbarItems = [NSArray arrayWithObjects:flexble, reGeocodeItem, flexble, locItem, flexble, nil];
    
    for (int i = 0; i<2; i++) {
        
        UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(30 + i*150, 100, 134, 40)];
        button.tag = 100+i;
        button.titleLabel.font = [UIFont systemFontOfSize:18];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];

        if (i == 0) {
             [button setTitle:@"带逆地理定位" forState:UIControlStateNormal];
        }else if (i == 1){
             [button setTitle:@"不带逆地理定位" forState:UIControlStateNormal];
            
        }
        button.layer.borderColor = [[UIColor blackColor] CGColor];
        
        button.layer.borderWidth = 1.2f;
        
        [self.view addSubview:button];
        
    }
}

- (void)btnClick:(UIButton *)sender{
    sender.selected = !sender.selected;
    
    NSInteger tag = sender.tag;
    if (tag == 100) {
        [self reGeocodeAction];
    }else if (tag == 101){
        [self locAction];
    }
    
}

- (void)initNavigationBar
{
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Clean"
                                                                              style:UIBarButtonItemStylePlain
                                                                             target:self
                                                                             action:@selector(cleanUpAction)];
}


#pragma mark - Initialization

- (void)initCompleteBlock
{
    __weak locatonViewController *weakSelf = self;
    self.completionBlock = ^(CLLocation *location, AMapLocationReGeocode *regeocode, NSError *error)
    {
        if (error != nil && error.code == AMapLocationErrorLocateFailed)
        {
            //定位错误：此时location和regeocode没有返回值，不进行annotation的添加
            NSLog(@"定位错误:{%ld - %@};", (long)error.code, error.localizedDescription);
            return;
        }
        else if (error != nil
                 && (error.code == AMapLocationErrorReGeocodeFailed
                     || error.code == AMapLocationErrorTimeOut
                     || error.code == AMapLocationErrorCannotFindHost
                     || error.code == AMapLocationErrorBadURL
                     || error.code == AMapLocationErrorNotConnectedToInternet
                     || error.code == AMapLocationErrorCannotConnectToHost))
        {
            //逆地理错误：在带逆地理的单次定位中，逆地理过程可能发生错误，此时location有返回值，regeocode无返回值，进行annotation的添加
            NSLog(@"逆地理错误:{%ld - %@};", (long)error.code, error.localizedDescription);
        }
        else if (error != nil && error.code == AMapLocationErrorRiskOfFakeLocation)
        {
            //存在虚拟定位的风险：此时location和regeocode没有返回值，不进行annotation的添加
            NSLog(@"存在虚拟定位的风险:{%ld - %@};", (long)error.code, error.localizedDescription);
            return;
        }
        else
        {
            //没有错误：location有返回值，regeocode是否有返回值取决于是否进行逆地理操作，进行annotation的添加
        }
        
        //修改label显示内容
        if (regeocode)
        {
            [weakSelf.displayLabel setText:[NSString stringWithFormat:@"%@ \n %@-%@-%.2fm", regeocode.formattedAddress,regeocode.citycode, regeocode.adcode, location.horizontalAccuracy]];
        }
        else
        {
            [weakSelf.displayLabel setText:[NSString stringWithFormat:@"lat:%f;lon:%f \n accuracy:%.2fm", location.coordinate.latitude, location.coordinate.longitude, location.horizontalAccuracy]];
            
            weakSelf.latitude = [NSString stringWithFormat:@"%.5f",location.coordinate.latitude];
            weakSelf.longitude = [NSString stringWithFormat:@"%.5f",location.coordinate.longitude ];
            
            [weakSelf setlocationToServer];
        }
    };
}

- (void)configLocationManager
{
    self.locationManager = [[AMapLocationManager alloc] init];
    
    [self.locationManager setDelegate:self];
    
    //设置期望定位精度
    [self.locationManager setDesiredAccuracy:kCLLocationAccuracyHundredMeters];
    
    //设置不允许系统暂停定位
    [self.locationManager setPausesLocationUpdatesAutomatically:NO];
    
    //设置允许在后台定位
    [self.locationManager setAllowsBackgroundLocationUpdates:YES];
    
    //设置定位超时时间
    [self.locationManager setLocationTimeout:DefaultLocationTimeout];
    
    //设置逆地理超时时间
    [self.locationManager setReGeocodeTimeout:DefaultReGeocodeTimeout];
}


- (void)reGeocodeAction
{
    //进行单次带逆地理定位请求
    [self.locationManager requestLocationWithReGeocode:YES completionBlock:self.completionBlock];
}

- (void)locAction
{
    //进行单次定位请求
    [self.locationManager requestLocationWithReGeocode:NO completionBlock:self.completionBlock];
}


- (void)initDisplayLabel
{
    self.displayLabel = [[UILabel alloc] init];
    self.displayLabel.frame = [UIScreen mainScreen].bounds;
    self.displayLabel.backgroundColor  = [UIColor clearColor];
    self.displayLabel.textColor        = [UIColor blackColor];
    self.displayLabel.textAlignment = NSTextAlignmentCenter;
    self.displayLabel.numberOfLines = 0;
    
    [self.view addSubview:_displayLabel];
}

-(void)dealloc{
    [self cleanUpAction];
    
    self.completionBlock = nil;

}

- (void)cleanUpAction
{
    //停止定位
    [self.locationManager stopUpdatingLocation];
    
    [self.locationManager setDelegate:nil];
    
    [self.displayLabel setText:nil];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.navigationController.toolbar.translucent   = YES;
    self.navigationController.toolbarHidden         = NO;
}

-(void)setlocationToServer{
    
    NSString * token = [[NSUserDefaults standardUserDefaults] objectForKey:@"deviceUUID"];

    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:token,@"token",@"guanal@hubeidaily",@"duserid",self.longitude,@"lng",self.latitude,@"lat",nil];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:@"http://123.56.219.172:12345/WebAppMap/addUserMapRecord" parameters:dic success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData: responseObject options:NSJSONReadingMutableContainers error:nil];
        
        
        NSString * str = [dic objectForKey:@"msg"];
        
        BOOL result = [[dic objectForKey:@"success"] boolValue];

        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
}



@end

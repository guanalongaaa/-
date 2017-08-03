//
//  AppDelegate.m
//  数据传递
//
//  Created by love on 2017/4/21.
//  Copyright © 2017年 guanal. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "FCUUID.h"
//#import "UUID/FCUUID.h"
#import <AMapFoundationKit/AMapFoundationKit.h>

//#import "NSNotificationCenterdefaultCenter"
#import <UserNotifications/UserNotifications.h>

#import <Photos/Photos.h>


@interface AppDelegate ()

@property (nonatomic, copy)NSString *uuidStr;//获取设备UUID

@property (nonatomic, strong) UIImageView * imageV;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.window = [[UIWindow alloc]initWithFrame:[[UIScreen mainScreen]bounds]];
    
    ViewController * viewC = [[ViewController alloc]init];
    
    UINavigationController * nai = [[UINavigationController alloc]initWithRootViewController:viewC];
    nai.navigationBar.backgroundColor = [UIColor whiteColor];
    
    nai.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObject:[UIColor greenColor] forKey:NSForegroundColorAttributeName];
    [nai.navigationBar setBackgroundImage:[UIImage imageNamed:@"guanal"] forBarMetrics:UIBarMetricsDefault];
    
    //获取该app 唯一设备id  (当用户系统重装无效)
    self.uuidStr = [[NSUserDefaults standardUserDefaults] objectForKey:@"deviceUUID"];
    if (self.uuidStr.length == 0) {
        [self deviceUUID];
    }
    
     [AMapServices sharedServices].apiKey = @"b7fad71cece22612ca7baa38d737af93";
    
    self.window.rootViewController = nai;
    [self.window makeKeyAndVisible];
    
    
//    NSOperationQueue *mainQueue = [NSOperationQueuemainQueue];
//    [[NSNotificationCenter defaultCenter] addObserverForName:UIApplicationUserDidTakeScreenshotNotification                                                       object:nilqueue:mainQueue usingBlock:^(NSNotification *note){
//        
//        [self jiePing];
//        
//    }];
    
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(jiePing) name:UIApplicationUserDidTakeScreenshotNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(jiePing) name:UIApplicationUserDidTakeScreenshotNotification object:nil];

    
    
    return YES;
}

-(void)jiePing
{
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"截屏提示" message:@"[安全提醒]可能含有安全信息，您的截屏操作已报告后台!" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action){
        
        NSLog(@"发送给后台");
        
    }];
    
    
    NSMutableAttributedString *alertControllerStr = [[NSMutableAttributedString alloc] initWithString:@"截屏提示"];
    [alertControllerStr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, 4)];
    [alertControllerStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:17] range:NSMakeRange(0, 4)];
    [alertController setValue:alertControllerStr forKey:@"attributedTitle"];

    [alertController addAction:cancelAction];
    [[self getCurrentVC] presentViewController:alertController animated:YES completion:nil];
    
    
//    PHFetchResult *collectonResuts = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeSmartAlbum subtype:PHAssetCollectionSubtypeAny options:[PHFetchOptions new]] ;
//    [collectonResuts enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
//        PHAssetCollection *assetCollection = obj;
//        
//        PHFetchResult *assetResult = [PHAsset fetchAssetsInAssetCollection:assetCollection options:[PHFetchOptions new]];
//        [assetResult enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
//            [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
//                //获取相册的最后一张照片
//                if (idx == [assetResult count] - 1) {
//                    [PHAssetChangeRequest deleteAssets:@[obj]];
//                    return;
//                }
//            } completionHandler:^(BOOL success, NSError *error) {
//                NSLog(@"Error: %@", error);
//            }];
//        }];
//
//    }];
    
}



- (NSString *)deviceUUID
{
    //如果内存不在,尝试从本地获取
    if (self.uuidStr.length==0) {
        self.uuidStr = [[NSUserDefaults standardUserDefaults] objectForKey:@"deviceUUID"];
        
        //如果本地不存在,从FCUUID获取
        if(self.uuidStr.length==0)
        {
            self.uuidStr = [FCUUID uuidForDevice];
            
            //如果FCUUID仍不存在,手动生成一个,并保存本地
            if (self.uuidStr.length ==0) {
                self.uuidStr = [self stringWithUUID];
            }
            
            [[NSUserDefaults standardUserDefaults] setObject:self.uuidStr forKey:@"deviceUUID"];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }
    }
    return self.uuidStr;
}
-(NSString *)stringWithUUID {
    CFUUIDRef UUIDObject = CFUUIDCreate(NULL);
    NSString *UUIDString = (NSString *)CFBridgingRelease(CFUUIDCreateString(nil, UUIDObject));
    CFRelease(UUIDObject);
    return UUIDString;
}

-(void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    NSString *strDeviceToken = [[[[deviceToken description] stringByReplacingOccurrencesOfString: @"<" withString: @""]                  stringByReplacingOccurrencesOfString: @">" withString: @""] stringByReplacingOccurrencesOfString: @" " withString: @""];
    
    NSLog(@"%@",strDeviceToken);
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    
    [self.imageV removeFromSuperview];
    self.imageV = nil;
    
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    
    [self.imageV removeFromSuperview];
    self.imageV = nil;

    
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


//2017.06.05 获取当前控制器
- (UIViewController *)getCurrentVC
{
    UIViewController *result = nil;
    
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows)
        {
            if (tmpWin.windowLevel == UIWindowLevelNormal)
            {
                window = tmpWin;
                break;
            }
        }
    }
    UIView *frontView = [[window subviews] objectAtIndex:0];
    id nextResponder = [frontView nextResponder];
    
    if ([nextResponder isKindOfClass:[UIViewController class]])
        result = nextResponder;
    else
        result = window.rootViewController;
    
    return result;
}



@end

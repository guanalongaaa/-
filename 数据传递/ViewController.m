//
//  ViewController.m
//  数据传递
//
//  Created by love on 2017/4/21.
//  Copyright © 2017年 guanal. All rights reserved.
//

#import "ViewController.h"

#import "BViewController.h"

#import "CViewController.h"

#import "DViewController.h"

#import "locatonViewController.h"

#import <AVFoundation/AVFoundation.h>
#import "NSString+EMOEmoji.h"

#import "modleView.h"
#import "UIView+Layout.h"
#import "SnailPopupController.h"

#import "CBPic2ker.h"

#import <Photos/Photos.h>
#import <AssetsLibrary/AssetsLibrary.h>

#define random(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)/255.0]

#define randomColor random(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256))

@interface ViewController ()<BViewControllerDelegate,CBPickerControllerDelegate>

/**
 需要传递的参数
 */
@property (nonatomic , strong) NSString * userStr;

/**
 跳转数组
 */
@property (nonatomic , strong) NSArray * titleArray;


// 声明音乐播放控件，必须声明为全局属性变量，否则可能不会播放，AVAudioPlayer 只能播放本地音乐
@property(nonatomic, retain)AVAudioPlayer *musicPlayer;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"首页";

    self.userStr = @"今天天气不错";
    
    [self.userStr emo_containsEmoji];
    
    self.titleArray = @[@"参数传值",@"block传值",@"加载HTML",@"弹出框",@"定位",@"设置",@"CBPic2ker"];
    
    [self creatUI];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSInteger k = 0;
    k++;
    NSLog(@"1 = %ld",k);
    [self count:k];
    NSLog(@"3 = %ld",k);
    
    
    UITapGestureRecognizer *doubleTapGestureRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(doubleTap:)];
    [doubleTapGestureRecognizer setNumberOfTapsRequired:2];
    [self.view addGestureRecognizer:doubleTapGestureRecognizer];
    
    CGRect rect =  CGRectIntegral(CGRectMake(20.3, 22, 104.8, 50));
    
    NSLog(@"logRect = %@", NSStringFromCGRect(rect));
    
}


- (void)doubleTap:(UIGestureRecognizer*)gestureRecognizer
{
    [self.view setBackgroundColor:[UIColor blueColor]];
    
    locatonViewController * LVC = [[locatonViewController alloc]init];
    [self.navigationController pushViewController:LVC animated:YES];
    NSLog(@"-----doubleTap-----");
}


-(void)count:(NSInteger)k{
    k++;
    NSLog(@"2 = %ld",k);
}

-(void)viewWillAppear:(BOOL)animated
{
    self.view.backgroundColor = randomColor;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(gnotification:) name:@"NSNotificationTitle" object:nil];
    
    int a = arc4random()%4;
//    NSLog(@"随机数---%d",a);
    if (a == 0) {
        //添加1/4崩溃几率
//        exit(2);
    }

    
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(jiePing) name:UIApplicationUserDidTakeScreenshotNotification object:nil];
    
}

-(void)jiePing{
    
    //人为截屏, 模拟用户截屏行为, 获取所截图片
    UIImage *image_ = [self imageWithScreenshot];
    
    //添加显示
    UIImageView *imgvPhoto = [[UIImageView alloc]initWithImage:image_];
    imgvPhoto.frame = CGRectMake(self.view.frame.size.width/2, self.view.frame.size.height/2, self.view.frame.size.width/2, self.view.frame.size.height/2);
    
    //添加边框
    CALayer * layer = [imgvPhoto layer];
    layer.borderColor = [
                         [UIColor whiteColor] CGColor];
    layer.borderWidth = 5.0f;
    //添加四个边阴影
    imgvPhoto.layer.shadowColor = [UIColor blackColor].CGColor;
    imgvPhoto.layer.shadowOffset = CGSizeMake(0, 0);
    imgvPhoto.layer.shadowOpacity = 0.5;
    imgvPhoto.layer.shadowRadius = 10.0;
    //添加两个边阴影
    imgvPhoto.layer.shadowColor = [UIColor blackColor].CGColor;
    imgvPhoto.layer.shadowOffset = CGSizeMake(4, 4);
    imgvPhoto.layer.shadowOpacity = 0.5;
    imgvPhoto.layer.shadowRadius = 2.0;
    
    [self.view addSubview:imgvPhoto];
    
}

//-(void)jiePing
//{
//    
//    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"新建文件夹" message:@"[安全提醒]内含付款码，只适合当面使用。不要截图或分享给他人以保障资金安全。" preferredStyle:UIAlertControllerStyleAlert];
//    
//    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"绝不给别人" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
//        return ;
//    }];
//    UIAlertAction *otherAction = [UIAlertAction actionWithTitle:@"仅我自己用" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
//        
//        PHFetchResult *collectonResuts = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeSmartAlbum subtype:PHAssetCollectionSubtypeAny options:[PHFetchOptions new]] ;
//        [collectonResuts enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
//            PHAssetCollection *assetCollection = obj;
//            
//            PHFetchResult *assetResult = [PHAsset fetchAssetsInAssetCollection:assetCollection options:[PHFetchOptions new]];
//            [assetResult enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
//                [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
//                    //获取相册的最后一张照片
//                    if (idx == [assetResult count] - 1) {
//                        [PHAssetChangeRequest deleteAssets:@[obj]];
//                    }
//                } completionHandler:^(BOOL success, NSError *error) {
//                    NSLog(@"Error: %@", error);
//                }];
//            }];
//            
////            if ([assetCollection.localizedTitle isEqualToString:@"Camera Roll"])  {
////                PHFetchResult *assetResult = [PHAsset fetchAssetsInAssetCollection:assetCollection options:[PHFetchOptions new]];
////                [assetResult enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
////                    [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
////                        //获取相册的最后一张照片
////                        if (idx == [assetResult count] - 1) {
////                            [PHAssetChangeRequest deleteAssets:@[obj]];
////                        }
////                    } completionHandler:^(BOOL success, NSError *error) {
////                        NSLog(@"Error: %@", error);
////                    }];
////                }];
////            }
//        }];
//        
//        
//    }];
//    
//    [alertController addAction:cancelAction];
//    [alertController addAction:otherAction];
//    [self presentViewController:alertController animated:YES completion:nil];
//    
//    
//    //    UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:nil message:@"[安全提醒]内含付款码，只适合当面使用。不要截图或分享给他人以保障资金安全。"delegate:selfcancelButtonTitle:@"绝不给别人"otherButtonTitles:@"仅我自己用",nil];
//    //    alertView.tag=105;
//    //    [alertView show];
//    
//    
//}




-(void)creatUI{
    
    
    for (NSInteger i = 0; i < self.titleArray.count ; i++) {
        
        UIButton * button = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 120, 40)];
        
        button.center = CGPointMake(self.view.center.x, 120 +(i * 60));
        
        button.backgroundColor = randomColor;
        
        button.tag = i + 1; 
        
        [button setTitle:self.titleArray[i] forState:UIControlStateNormal];
        
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.view addSubview:button];
        
        
    }
    
    
    
}


-(void)buttonClick:(UIButton *)sender{
    
    NSLog(@"点击了第%ld个",(long)sender.tag);
    
    switch (sender.tag) {
        case 1:
        {
            BViewController * bView = [[BViewController alloc]init];
            
            bView.recText = self.userStr;
            
            bView.delegate = self;
            
            [self.navigationController pushViewController:bView animated:YES];
        }
            
            break;
        case 2:
        {
            CViewController * cView = [[CViewController alloc]init];
            
             //赋值Block，并将捕获的值赋值给UILabel
            cView.returnValueBlock = ^(NSString *strValue) {

                self.title = strValue;
                
            };
            
            [self.navigationController pushViewController:cView animated:YES];
        }
            
            break;
        case 3:
        {
            DViewController * bView = [[DViewController alloc]init];
            
            [self.navigationController pushViewController:bView animated:YES];
        }
            
            break;
        case 4:
        {
            NSLog(@"弹出右滑视图");
            modleView *sidebar = [self sidebarView];
            
            sidebar.closeClicked = ^(UIButton *closeButton) {
                [self.sl_popupController dismissWithDuration:0.25 elasticAnimated:NO];
            };
            
            self.sl_popupController = [SnailPopupController new];
            self.sl_popupController.layoutType = PopupLayoutTypeLeft;
            self.sl_popupController.allowPan = YES;
            [self.sl_popupController presentContentView:sidebar];
        }
            
            break;
        case 5:
        {
            NSLog(@"定位");
            locatonViewController * LVC = [[locatonViewController alloc]init];
            [self.navigationController pushViewController:LVC animated:YES];
            
        }
            break;
        case 6:
        {
          
//            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"prefs:root=General&path=About"] options:@{UIApplicationOpenURLOptionUniversalLinksOnly:@"YES"} completionHandler:nil];
            
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString] options:@{} completionHandler:nil];
            
        }
        case 7:
        {
            CBPhotoSelecterController *controller = [[CBPhotoSelecterController alloc] initWithDelegate:self];
            controller.columnNumber = 4;
            controller.maxSlectedImagesCount = 5;
            UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:controller];
            [self presentViewController:nav animated:YES completion:nil];
        }

            break;

            
        default:
            break;
    }
}


- (modleView *)sidebarView {
    
    modleView *sidebarView = [modleView new];
    NSLog(@"X--%f，Y--%f",[[UIScreen mainScreen] bounds].size.width,[[UIScreen mainScreen] bounds].size.height);
    sidebarView.size = CGSizeMake(375, 375);
    sidebarView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    sidebarView.models = @[@"我的故事", @"消息中心", @"我的收藏", @"近期阅读", @"离线阅读"];
    return sidebarView;
}


-(void)bViewController:(BViewController *)bVC clickBtnReturn:(NSString *)message
{
    self.title = message;
}

-(void)gnotification:(NSNotification *)note{
    
    NSString * string = note.object;
    
    self.title = string;
    
}


- (void)photoSelecterController:(CBPhotoSelecterController *)pickerController sourceAsset:(NSArray *)sourceAsset {
    NSLog(@"%lu",(unsigned long)sourceAsset.count);
    if (sourceAsset.count == 0) {
        NSLog(@"啥都没选");
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}
- (void)photoSelecterDidCancelWithController:(CBPhotoSelecterController *)pickerController {
    NSLog(@"%ld",(long)pickerController.columnNumber);
    
    [self dismissViewControllerAnimated:YES completion:nil];
//    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/**
 *  截取当前屏幕
 *
 *  @return NSData *
 */
- (NSData *)dataWithScreenshotInPNGFormat
{
    CGSize imageSize = CGSizeZero;
    UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
    if (UIInterfaceOrientationIsPortrait(orientation))
        imageSize = [UIScreen mainScreen].bounds.size;
    else
        imageSize = CGSizeMake([UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width);
    
    UIGraphicsBeginImageContextWithOptions(imageSize, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    for (UIWindow *window in [[UIApplication sharedApplication] windows])
    {
        CGContextSaveGState(context);
        CGContextTranslateCTM(context, window.center.x, window.center.y);
        CGContextConcatCTM(context, window.transform);
        CGContextTranslateCTM(context, -window.bounds.size.width * window.layer.anchorPoint.x, -window.bounds.size.height * window.layer.anchorPoint.y);
        if (orientation == UIInterfaceOrientationLandscapeLeft)
        {
            CGContextRotateCTM(context, M_PI_2);
            CGContextTranslateCTM(context, 0, -imageSize.width);
        }
        else if (orientation == UIInterfaceOrientationLandscapeRight)
        {
            CGContextRotateCTM(context, -M_PI_2);
            CGContextTranslateCTM(context, -imageSize.height, 0);
        } else if (orientation == UIInterfaceOrientationPortraitUpsideDown) {
            CGContextRotateCTM(context, M_PI);
            CGContextTranslateCTM(context, -imageSize.width, -imageSize.height);
        }
        if ([window respondsToSelector:@selector(drawViewHierarchyInRect:afterScreenUpdates:)])
        {
            [window drawViewHierarchyInRect:window.bounds afterScreenUpdates:YES];
        }
        else
        {
            [window.layer renderInContext:context];
        }
        CGContextRestoreGState(context);
    }
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return UIImagePNGRepresentation(image);
}

/**
 *  返回截取到的图片
 *
 *  @return UIImage *
 */
- (UIImage *)imageWithScreenshot
{
    NSData *imageData = [self dataWithScreenshotInPNGFormat];
    return [UIImage imageWithData:imageData];
}


@end

//
//  AVPlayerObject.m
//  数据传递
//
//  Created by love on 2017/5/5.
//  Copyright © 2017年 guanal. All rights reserved.
//

#import "AVPlayerObject.h"

#import <AVFoundation/AVFoundation.h>

@interface AVPlayerObject ()

// 声明音乐播放控件，必须声明为全局属性变量，否则可能不会播放，AVAudioPlayer 只能播放本地音乐
@property(nonatomic, retain)AVAudioPlayer *musicPlayer;


@end

@implementation AVPlayerObject

static AVPlayerObject * avPlayerObj;

+(instancetype)shartAVPlayer
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        avPlayerObj = [[AVPlayerObject alloc]init];
    });
    return avPlayerObj;
}

-(void)setUpAVPlayer
{
    // 获取音乐文件路径
    NSURL *musicUrl = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"陈慧娴 - 傻女" ofType:@"mp3"]];
    
    // 实例化音乐播放控件
    self.musicPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:musicUrl error:nil];
    
    // 准备（缓冲）播放
    [self.musicPlayer prepareToPlay];
    
    // 开始播放音乐
    [self.musicPlayer play];

}

-(void)pauseAVPlayer
{
    [self.musicPlayer stop];
}


@end

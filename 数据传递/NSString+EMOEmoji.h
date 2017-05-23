//
//  NSString+EMOEmoji.h
//  数据传递
//
//  Created by love on 2017/5/11.
//  Copyright © 2017年 guanal. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (EMOEmoji)

/**
 Calculate the NSRange for every emoji on the string.
 
 @return array with the range for every emoji.
 */
- (NSArray *)emo_emojiRanges;

/**
 Calculate if the string has any emoji.
 
 @return YES if the string has emojis, No otherwise.
 */
- (BOOL)emo_containsEmoji;

/**
 Calculate if the string consists entirely of emoji.
 
 @return YES if the string consists entirely of emoji, No otherwise.
 */
- (BOOL)emo_isPureEmojiString;

/**
 Calculate number of emojis on the string.
 
 @return the total number of emojis.
 */
- (NSInteger)emo_emojiCount;



@end

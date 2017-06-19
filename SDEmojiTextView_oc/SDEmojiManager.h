//
//  SDEmojiManager.h
//  SDEmojiTextView_oc
//
//  Created by shansander on 2017/6/15.
//  Copyright © 2017年 shansander. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface SDEmojiManager : NSObject

@property (nonatomic, strong) NSDictionary * emojiInfo;

@property (nonatomic, strong) NSArray * emoji_List;
+ (SDEmojiManager *)getEmojiSingleton;

@end

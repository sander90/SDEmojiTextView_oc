//
//  SDEmojiManager.m
//  SDEmojiTextView_oc
//
//  Created by shansander on 2017/6/15.
//  Copyright © 2017年 shansander. All rights reserved.
//

#import "SDEmojiManager.h"

@implementation SDEmojiManager

+ (SDEmojiManager *)getEmojiSingleton
{
    static SDEmojiManager * emojiSingleton;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        emojiSingleton = [[SDEmojiManager alloc] init];
    });
    return emojiSingleton;
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self configEmojiData];
    }
    return self;
}

- (void)configEmojiData
{
    NSString * emoji_plist_path = [[NSBundle mainBundle] pathForResource:@"emoji" ofType:@"plist"];
    
    NSDictionary * emoji_info = [[[NSArray alloc] initWithContentsOfFile:emoji_plist_path] firstObject];
    NSArray * emoji_list = emoji_info[@"data"];
    
    self.emoji_List = emoji_list;
    NSMutableDictionary * tmp_info = [NSMutableDictionary dictionaryWithCapacity:0];
    for (NSDictionary * obj in emoji_list) {
        tmp_info[obj[@"tag"]] = [UIImage imageNamed:obj[@"file"]];
    }
    
    self.emojiInfo = [tmp_info copy];
    
    
}

@end

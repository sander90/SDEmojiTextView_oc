//
//  YYTextView+SDChangeForEmoji.h
//  SDEmojiTextView_oc
//
//  Created by shansander on 2017/6/17.
//  Copyright © 2017年 shansander. All rights reserved.
//

#import <YYText/YYText.h>

@interface YYTextView (SDChangeForEmoji)

@property (nonatomic, assign) NSRange textSelectedRange;

@property (nonatomic, assign) BOOL canChangeTextSelectedRange;

- (void)changeTextSelectedRange;

- (void)insertEmojiText:(NSString *)emoji;

@end

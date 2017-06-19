//
//  SDEmojiActivityView.h
//  SDEmojiTextView_oc
//
//  Created by shansander on 2017/6/15.
//  Copyright © 2017年 shansander. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SDEmojiDelegate <NSObject>

- (void)EmojiDidSelectedWithEmojiTag:(NSString *)tag;


@end

@interface SDEmojiActivityView : UIView

@property (nonatomic, weak) id<SDEmojiDelegate> delegate;


@end

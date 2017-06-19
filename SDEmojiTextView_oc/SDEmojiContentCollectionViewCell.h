//
//  SDEmojiContentCollectionViewCell.h
//  SDEmojiTextView_oc
//
//  Created by shansander on 2017/6/15.
//  Copyright © 2017年 shansander. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SDEmojiContentCollectionViewCell : UICollectionViewCell
@property(nonatomic, weak) UIImageView * emoji_imageView;

@property (nonatomic, strong) NSDictionary * emoji_info;

+ (NSString * )reuseIdentifier;

- (void)loadEmojiInfo:(NSDictionary * )info;

@end

//
//  SDEmojiContentCollectionViewCell.m
//  SDEmojiTextView_oc
//
//  Created by shansander on 2017/6/15.
//  Copyright © 2017年 shansander. All rights reserved.
//

#import "SDEmojiContentCollectionViewCell.h"
#import <Masonry.h>

@implementation SDEmojiContentCollectionViewCell

+ (NSString * )reuseIdentifier
{
    return NSStringFromClass(self);
}

- (void)loadEmojiInfo:(NSDictionary * )info
{
    _emoji_info = info;
    
    NSString * imageName = _emoji_info[@"file"];
    
    self.emoji_imageView.image = [UIImage imageNamed:imageName];
    
}


- (UIImageView *)emoji_imageView
{
    if (!_emoji_imageView) {
        UIImageView * theView = [[UIImageView alloc] init];
        [self.contentView addSubview:theView];
        [theView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self.contentView);
            make.size.mas_equalTo(CGSizeMake(20, 20));
        }];
        
        _emoji_imageView = theView;
    }
    return _emoji_imageView;
}

@end

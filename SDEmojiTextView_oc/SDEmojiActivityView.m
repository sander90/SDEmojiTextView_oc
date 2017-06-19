//
//  SDEmojiActivityView.m
//  SDEmojiTextView_oc
//
//  Created by shansander on 2017/6/15.
//  Copyright © 2017年 shansander. All rights reserved.
//

#import "SDEmojiActivityView.h"
#import "SDEmojiContentCollectionViewCell.h"
#import <Masonry.h>
#import "SDEmojiManager.h"
@interface SDEmojiActivityView ()<UICollectionViewDataSource,UICollectionViewDelegate>

@property (nonatomic, weak) UICollectionView * emojiCollectionView;

@end

@implementation SDEmojiActivityView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self emojiCollectionView];
    }
    return self;
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [SDEmojiManager getEmojiSingleton].emoji_List.count;
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    SDEmojiContentCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:[SDEmojiContentCollectionViewCell reuseIdentifier] forIndexPath:indexPath];
    NSDictionary * emoji_info = [SDEmojiManager getEmojiSingleton].emoji_List[indexPath.row];
    
//    cell.contentView.layer.borderColor = [UIColor redColor].CGColor;
//    cell.contentView.layer.borderWidth = 1.f;
    [cell loadEmojiInfo:emoji_info];
    return cell;
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary * emoji_info = [SDEmojiManager getEmojiSingleton].emoji_List[indexPath.row];
    if (self.delegate && [self.delegate respondsToSelector:@selector(EmojiDidSelectedWithEmojiTag:)]) {
        [self.delegate EmojiDidSelectedWithEmojiTag:emoji_info[@"tag"]];
    }
    
}


#pragma mark - lazy



- (UICollectionView *)emojiCollectionView
{
    if (!_emojiCollectionView) {
        UICollectionViewFlowLayout * flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        
        
        UICollectionView * theView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        [self addSubview:theView];
        theView.dataSource = self;
        theView.delegate = self;
        
        [theView registerClass:[SDEmojiContentCollectionViewCell class] forCellWithReuseIdentifier:[SDEmojiContentCollectionViewCell reuseIdentifier]];
        [theView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self);
            make.left.equalTo(self);
            make.right.equalTo(self);
            make.bottom.equalTo(self);
        }];
        
        _emojiCollectionView = theView;
    }
    return _emojiCollectionView;
}



@end

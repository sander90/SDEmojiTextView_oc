//
//  ViewController.m
//  SDEmojiTextView_oc
//
//  Created by shansander on 2017/6/15.
//  Copyright © 2017年 shansander. All rights reserved.
//

#import "ViewController.h"
#import <YYTextView.h>
#import <Masonry.h>
#import "SDEmojiManager.h"

#import "SDEmojiActivityView.h"

#import "YYTextView+SDChangeForEmoji.h"

@interface ViewController ()<SDEmojiDelegate,YYTextViewDelegate>

@property (nonatomic, weak) YYTextView * inputView;

@property (nonatomic, strong) YYTextSimpleEmoticonParser * emoticonParser;

@property (nonatomic, weak) SDEmojiActivityView * emojiAction;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.inputView.layer.borderColor = [UIColor redColor].CGColor;
    self.inputView.layer.borderWidth = 1.f;
    
    
    [self emojiAction];
    // Do any additional setup after loading the view, ty.pically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - SDEmojiDelegate

- (void)EmojiDidSelectedWithEmojiTag:(NSString *)tag
{
    
    [self.inputView insertEmojiText:tag];

}
#pragma mark - YYTextViewDelegate
- (void)textViewDidChangeSelection:(YYTextView *)textView
{
    NSRange selectionRange = textView.selectedRange;
    
    NSLog(@"-%@",NSStringFromRange(selectionRange));
    
    [textView changeTextSelectedRange];
    

}


#pragma mark - lazy

- (YYTextView *)inputView
{
    if (!_inputView) {
        YYTextView * theView = [[YYTextView alloc] init];
        [self.view addSubview:theView];
        [theView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.view).offset(15);
            make.right.equalTo(self.view).offset(-15);
            make.height.mas_equalTo(50.f);
            make.top.equalTo(self.view).offset(100);
        }];
        theView.delegate = self;
        theView.canChangeTextSelectedRange = YES;
        theView.placeholderText = @"请输入内容...";
        self.emoticonParser.emoticonMapper = [SDEmojiManager getEmojiSingleton].emojiInfo;
        theView.textParser = self.emoticonParser;
        _inputView = theView;
    }
    return _inputView;
}
- (SDEmojiActivityView*)emojiAction
{
    if (!_emojiAction) {
        SDEmojiActivityView * theView = [[SDEmojiActivityView alloc] init];
        [self.view addSubview:theView];
        [theView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.view);
            make.right.equalTo(self.view);
            make.bottom.equalTo(self.view);
            make.height.mas_equalTo(200);
        }];
        theView.delegate = self;
        _emojiAction = theView;
    }
    return _emojiAction;
}

- (YYTextSimpleEmoticonParser *)emoticonParser
{
    if (!_emoticonParser) {
        _emoticonParser = [[YYTextSimpleEmoticonParser alloc] init];
    }
    return _emoticonParser;
}

@end

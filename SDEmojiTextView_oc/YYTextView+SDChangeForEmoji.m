//
//  YYTextView+SDChangeForEmoji.m
//  SDEmojiTextView_oc
//
//  Created by shansander on 2017/6/17.
//  Copyright © 2017年 shansander. All rights reserved.
//

#import "YYTextView+SDChangeForEmoji.h"
#import <objc/runtime.h>
static const void * KTextSelectedRange = "textSelectedRange";

static const void * KCanChangeTextSelectedRange = "canChangeTextSelectedRange";

@implementation YYTextView (SDChangeForEmoji)



- (NSRange )textSelectedRange
{
    return [objc_getAssociatedObject(self, KTextSelectedRange) rangeValue];
}

-(void)setTextSelectedRange:(NSRange)textSelectedRange
{
    if (self.canChangeTextSelectedRange) {
        objc_setAssociatedObject(self, KTextSelectedRange, [NSValue valueWithRange:textSelectedRange], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
}
- (BOOL)canChangeTextSelectedRange
{
    return [objc_getAssociatedObject(self, KCanChangeTextSelectedRange) boolValue];
}

- (void)setCanChangeTextSelectedRange:(BOOL)canChangeTextSelectedRange
{
    objc_setAssociatedObject(self, KCanChangeTextSelectedRange, [NSNumber numberWithBool:canChangeTextSelectedRange], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)insertEmojiText:(NSString *)emoji
{
    NSString * text = self.text;
    
    NSLog(@"--->  %@",text);
    
    NSLog(@"text selected range -%@",NSStringFromRange(self.textSelectedRange));

    
    text = [text stringByReplacingCharactersInRange:NSMakeRange(self.textSelectedRange.location, 0) withString:emoji];
    
    self.textSelectedRange = NSMakeRange(self.textSelectedRange.location + emoji.length,0);
    
    self.canChangeTextSelectedRange = false;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.003 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.canChangeTextSelectedRange = true;
    });
    
    
    self.text = text;
//    self.selectedRange = NSMakeRange(self.selectedRange.location + 1, 0);

}


- (void)changeTextSelectedRange
{
    // 如果是直接输入emoji，selectedRange是（1，0），蛋疼的问题
    NSRange selected_range = self.selectedRange;
    
    NSLog(@"%@",NSStringFromRange(selected_range));
    
    [self checkouthasEmojiByRange:selected_range];
    
}

//TODO: 得到之前的有没有emoji的表情[OK]
- (void)checkouthasEmojiByRange:(NSRange )selectedRange
{
    __block NSRange range = selectedRange;

    if (self.text.length > 0) {
        
        NSString *regex = @"\\[[a-zA-Z0-9\\u4e00-\\u9fa5]+\\]";
        NSError *error;
        NSRegularExpression *regular = [NSRegularExpression regularExpressionWithPattern:regex
                                                                                 options:NSRegularExpressionCaseInsensitive
                                                                                   error:&error];
        
        NSMutableArray * tokens = [NSMutableArray arrayWithCapacity:0];
        
        int (^ gettokensLength)(NSArray * list) = ^(NSArray * list){
            int length = 0 ;
            for (NSValue * value in list) {
                NSRange range = [value rangeValue];
                length += range.length - 1;
            }
            
            return length;
        };
        
        __block NSInteger index = 0;
        __block NSInteger local_length = 0;
        
        __block BOOL isFinish = false;
        
        [regular enumerateMatchesInString:self.text options:0 range:NSMakeRange(0, self.text.length) usingBlock:^(NSTextCheckingResult * _Nullable result, NSMatchingFlags flags, BOOL * _Nonnull stop) {
            
            NSString * text = [self.text substringWithRange:result.range];
            //2. 在出现emoji之前，先判断他之前的文字，
            if (tokens.count > 0) {
                // 2.1 出现第二个emoji，或者更多的时候，计算出，他们之间的文字个数
                NSValue * lastValue = [tokens lastObject];
                
                NSRange lastRange = [lastValue rangeValue];
                
                NSInteger tmp_le = result.range.location - lastRange.location - lastRange.length;
                // two emoji spacing is 0 ,
                //
                index += tmp_le ;
                if (tmp_le == 0) {
                    // 说明两个都是图标
                }
                
            }else{
                // 2.2 出现emoji，计算之前出现文字个数
                index += result.range.location;
            }
            
            //3 计算光标出现的位置，如果能定位到，
            if (range.location <= index) {
                // 3.1 获取之前的emoji的文字的长度，
                int emoji_length = gettokensLength(tokens);
                // 3.2 计算出光标之前的文字的长度 包含emoji的文字的长度
                range = NSMakeRange(selectedRange.location + emoji_length, 0);
                isFinish = true;
                *stop = YES; // 结束的标志
                return ;
            }else{
                
            }
            
            if (result.range.location == 0 && result.range.length == 0) {
                
            }else{
                // 4. 捕捉到一个emoji，
                
                index += 1;
                [tokens addObject:[NSValue valueWithRange:result.range]];
                // 4.1 捕捉到一个emoji，得到之前所有的长度
                local_length = result.range.location + result.range.length;
                if (selectedRange.location <= index) {
                    
                    int emoji_length = gettokensLength(tokens);
                    range = NSMakeRange(selectedRange.location + emoji_length, 0);
                    isFinish = true;
                    *stop = YES;
                }else{
                    
                }
            }
            
        }];
        
        // 5.捕捉到最后一emoji之后的文字
        if (!isFinish) {
            if (local_length <= self.text.length) {
                if (selectedRange.location >= index) {
                    int emoji_length = gettokensLength(tokens);
                    range = NSMakeRange(selectedRange.location + emoji_length, 0);
                }
                
            }
            
        }

    }
    
    self.textSelectedRange = range;
    
}



@end

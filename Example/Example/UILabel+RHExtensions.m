//
//  UILabel+RHExtensions.m
//  Example
//
//  Created by zhuruhong on 2017/4/19.
//  Copyright © 2017年 zhuruhong. All rights reserved.
//

#import "UILabel+RHExtensions.h"
#import "RHHtmlParser.h"

@implementation UILabel (RHExtensions)

- (void)setHtmlText:(NSString *)inHtmlText
{
    RHHtmlParser *htmlParser = [[RHHtmlParser alloc] init];
    NSAttributedString *attributedString = [htmlParser parseString:inHtmlText filter:nil];
    if (attributedString) {
        self.attributedText = attributedString;
    } else {
        self.text = inHtmlText;
    }
}

#pragma mark - UIResponder

- (BOOL)canBecomeFirstResponder
{
    return YES;
}

- (BOOL)canPerformAction:(SEL)action withSender:(id)sender
{
#if !TARGET_OS_TV
    return (action == @selector(copy:));
#else
    return NO;
#endif
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint touchPoint = [touch locationInView:self];
    //TODO: 计算点击的位置
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{}

@end

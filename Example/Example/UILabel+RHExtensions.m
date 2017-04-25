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
    NSAttributedString *attributedString = [htmlParser parseString:inHtmlText filter:nil error:nil];
    if (attributedString) {
        self.attributedText = attributedString;
    } else {
        self.text = inHtmlText;
    }
}

@end

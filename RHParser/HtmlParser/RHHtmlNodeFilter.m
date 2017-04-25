//
//  RHHtmlNodeFilter.m
//  Example
//
//  Created by zhuruhong on 2017/4/25.
//  Copyright © 2017年 zhuruhong. All rights reserved.
//

#import "RHHtmlNodeFilter.h"
#import "RHNode.h"

@implementation RHHtmlNodeFilter

- (BOOL)filter:(RHNode *)inNode
{
    if ([inNode.name isEqualToString:@"html"]) {
        return YES;
    }
    if ([inNode.name isEqualToString:@"body"]) {
        return YES;
    }
    return NO;
}

@end

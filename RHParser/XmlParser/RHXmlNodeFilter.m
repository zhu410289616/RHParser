//
//  RHXmlNodeFilter.m
//  Example
//
//  Created by zhuruhong on 2017/4/26.
//  Copyright © 2017年 zhuruhong. All rights reserved.
//

#import "RHXmlNodeFilter.h"
#import "RHNode.h"

@implementation RHXmlNodeFilter

- (BOOL)filter:(RHNode *)inNode
{
    if ([inNode.name isEqualToString:@"root"]) {
        return YES;
    }
    return NO;
}

@end

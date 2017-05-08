//
//  RHNodeLink.m
//  Example
//
//  Created by zhuruhong on 2017/5/3.
//  Copyright © 2017年 zhuruhong. All rights reserved.
//

#import "RHNodeLink.h"

@implementation RHNodeLink

- (instancetype)initWithAttributes:(NSDictionary *)attributes
                  activeAttributes:(NSDictionary *)activeAttributes
                inactiveAttributes:(NSDictionary *)inactiveAttributes
                textCheckingResult:(NSTextCheckingResult *)result
{
    if (self = [super init]) {
        _result = result;
        _attributes = attributes;
        _activeAttributes = activeAttributes;
        _inactiveAttributes = inactiveAttributes;
    }
    return self;
}

@end

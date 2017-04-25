//
//  RHNode.m
//  RHLabel
//
//  Created by zhuruhong on 2017/4/17.
//  Copyright © 2017年 zhuruhong. All rights reserved.
//

#import "RHNode.h"
#import "RHNodeFilter.h"
#import "RHNodeList.h"

@implementation RHNode

- (instancetype)initWithXmlNode:(xmlNodePtr)inNode
{
    if (self = [super init]) {
        _node = inNode;
    }
    return self;
}

- (void)addAttributes:(NSDictionary *)inAttributes
{
    if (inAttributes.count == 0) {
        return;
    }
    NSMutableDictionary *theAttributes = [NSMutableDictionary dictionary];
    if (_attributes.count > 0) {
        [theAttributes addEntriesFromDictionary:_attributes];
    }
    [theAttributes addEntriesFromDictionary:inAttributes];
    _attributes = theAttributes;
}

- (void)collectInfo:(RHNodeFilter *)inNodeFilter nodeList:(RHNodeList *)outNodeList
{
    if ([inNodeFilter filter:self]) {
        return;
    }
    [outNodeList addNode:self];
}

@end

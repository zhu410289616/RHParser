//
//  RHNodeList.m
//  RHLabel
//
//  Created by zhuruhong on 2017/4/17.
//  Copyright © 2017年 zhuruhong. All rights reserved.
//

#import "RHNodeList.h"

@interface RHNodeList ()

@property (nonatomic, strong) NSMutableArray<RHNode *> *nodes;

@end

@implementation RHNodeList

- (instancetype)init
{
    if (self = [super init]) {
        _nodes = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)addNode:(RHNode *)node
{
    if (nil == node) {
        return;
    }
    [_nodes addObject:node];
}

- (void)addNodeList:(RHNodeList *)nodeList
{
    if (nil == [nodeList nodes]) {
        return;
    }
    [_nodes addObjectsFromArray:[nodeList nodes]];
}

- (NSUInteger)count
{
    return _nodes.count;
}

- (RHNode *)nodeWithIndex:(NSInteger)index
{
    if (index >= _nodes.count) {
        return nil;
    }
    return _nodes[index];
}

- (NSArray<RHNode *> *)nodes
{
    return _nodes;
}

- (RHNode *)removeNodeWithIndex:(NSInteger)index
{
    RHNode *node = [self nodeWithIndex:index];
    if (node) {
        [_nodes removeObject:node];
    }
    return node;
}

- (void)removeAllNodes
{
    [_nodes removeAllObjects];
}

- (BOOL)containsNode:(RHNode *)node
{
    if (nil == node) {
        return NO;
    }
    return [_nodes containsObject:node];
}

- (BOOL)removeNode:(RHNode *)node
{
    if (nil == node) {
        return NO;
    }
    [_nodes removeObject:node];
    return YES;
}

@end

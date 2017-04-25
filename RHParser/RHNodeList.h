//
//  RHNodeList.h
//  RHLabel
//
//  Created by zhuruhong on 2017/4/17.
//  Copyright © 2017年 zhuruhong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class RHNode;

@interface RHNodeList : NSObject

- (void)addNode:(RHNode *)node;
- (void)addNodeList:(RHNodeList *)nodeList;
- (NSUInteger)count;
- (RHNode *)nodeWithIndex:(NSInteger)index;
- (NSArray<RHNode *> *)nodes;
- (RHNode *)removeNodeWithIndex:(NSInteger)index;
- (void)removeAllNodes;
- (BOOL)containsNode:(RHNode *)node;
- (BOOL)removeNode:(RHNode *)node;

@end

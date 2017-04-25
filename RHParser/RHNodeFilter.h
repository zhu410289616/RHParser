//
//  RHNodeFilter.h
//  RHLabel
//
//  Created by zhuruhong on 2017/4/17.
//  Copyright © 2017年 zhuruhong. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RHNode;

@protocol RHNodeFilter <NSObject>

- (BOOL)filter:(RHNode *)inNode;

@end

@interface RHNodeFilter : NSObject <RHNodeFilter>

@end

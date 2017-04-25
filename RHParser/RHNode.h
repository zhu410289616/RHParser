//
//  RHNode.h
//  RHLabel
//
//  Created by zhuruhong on 2017/4/17.
//  Copyright © 2017年 zhuruhong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <libxml2/libxml/HTMLparser.h>

@class RHNodeFilter;
@class RHNodeList;

@protocol RHNode <NSObject>

- (void)collectInfo:(RHNodeFilter *)inNodeFilter nodeList:(RHNodeList *)outNodeList;

@end

@interface RHNode : NSObject <RHNode>

@property (nonatomic, assign) xmlNodePtr node;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) NSDictionary *attributes;

- (instancetype)initWithXmlNode:(xmlNodePtr)inNode;
- (void)addAttributes:(NSDictionary *)inAttributes;

@end

//
//  RHNodeLink.h
//  Example
//
//  Created by zhuruhong on 2017/5/3.
//  Copyright © 2017年 zhuruhong. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, RHNodeLinkType) {
    RHNodeLinkTypeNone = 0,
    RHNodeLinkTypeWeb,
    RHNodeLinkTypeTopic,
    RHNodeLinkTypeKeyword
};

@interface RHNodeLink : NSObject

@property (nonatomic, assign) NSRange range;
@property (nonatomic, assign) RHNodeLinkType linkType;

@property (nonatomic, strong, readonly) NSTextCheckingResult *result;
@property (nonatomic, strong, readonly) NSDictionary *attributes;
@property (nonatomic, strong, readonly) NSDictionary *activeAttributes;
@property (nonatomic, strong, readonly) NSDictionary *inactiveAttributes;

/**
 Initializes a link using the attribute dictionaries specified.
 
 @param attributes         The @c attributes property for the link.
 @param activeAttributes   The @c activeAttributes property for the link.
 @param inactiveAttributes The @c inactiveAttributes property for the link.
 @param result             An @c NSTextCheckingResult representing the link's location and type.
 
 @return The initialized link object.
 */
- (instancetype)initWithAttributes:(NSDictionary *)attributes
                  activeAttributes:(NSDictionary *)activeAttributes
                inactiveAttributes:(NSDictionary *)inactiveAttributes
                textCheckingResult:(NSTextCheckingResult *)result;

@end

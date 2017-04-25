//
//  RHParser.h
//  RHLabel
//
//  Created by zhuruhong on 2017/4/17.
//  Copyright © 2017年 zhuruhong. All rights reserved.
//

//svn checkout https://svn.code.sf.net/p/htmlparser/code/trunk htmlparser-code

#import <Foundation/Foundation.h>

#define RHParserDebug

#ifdef RHParserDebug
#define RHParserLog(format, ...) NSLog(format, ## __VA_ARGS__)
#else
#define RHParserLog(format, ...)
#endif

extern NSString * const RHParserDomain;

@class RHNode;
@class RHNodeList;
@class RHNodeFilter;

typedef NSAttributedString *(^RHNodeBlock)(RHNode *node, NSDictionary *defaultStyles);

@protocol RHParser <NSObject>

- (RHNodeList *)nodeListWithString:(NSString *)inString filter:(RHNodeFilter *)inFilter error:(NSError **)outError;
- (NSAttributedString *)parseString:(NSString *)inString filter:(RHNodeFilter *)inFilter error:(NSError **)outError;

@end

@interface RHParser : NSObject <RHParser>

@property (nonatomic, strong, readonly) NSMutableDictionary *stylesMap;
@property (nonatomic, strong, readonly) NSMutableDictionary *nodeBlocksMap;

- (void)addStyle:(NSDictionary *)inStyle forTag:(NSString *)inTag;
- (void)removeStyleForTag:(NSString *)inTag;

- (void)addNodeBlock:(RHNodeBlock)inNodeBlock forTag:(NSString *)inTag;
- (void)removeNodeBlockForTag:(NSString *)inTag;

@end

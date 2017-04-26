//
//  RHParser.m
//  RHLabel
//
//  Created by zhuruhong on 2017/4/17.
//  Copyright © 2017年 zhuruhong. All rights reserved.
//

#import "RHParser.h"

NSString * const RHParserDomain = @"RHParserDomain";

@implementation RHParser

- (instancetype)init
{
    if (self = [super init]) {
        _nodeBlocksMap = [NSMutableDictionary dictionary];
        _stylesMap = [NSMutableDictionary dictionary];
    }
    return self;
}

- (void)addStyle:(NSDictionary *)inStyle forTag:(NSString *)inTag
{
    self.stylesMap[inTag] = inStyle;
}

- (void)removeStyleForTag:(NSString *)inTag
{
    [self.stylesMap removeObjectForKey:inTag];
}

- (void)addNodeBlock:(RHNodeBlock)inNodeBlock forTag:(NSString *)inTag
{
    self.nodeBlocksMap[inTag] = inNodeBlock;
}

- (void)removeNodeBlockForTag:(NSString *)inTag
{
    [self.nodeBlocksMap removeObjectForKey:inTag];
}

- (RHNodeList *)nodeListWithString:(NSString *)inString filter:(RHNodeFilter *)inFilter
{
    return nil;
}

- (NSAttributedString *)parseString:(NSString *)inString filter:(RHNodeFilter *)inFilter
{
    return nil;
}

@end

@implementation RHParser (Error)

- (NSError *)errorWithCode:(NSInteger)code UserInfo:(NSDictionary *)userInfo
{
    return [NSError errorWithDomain:RHParserDomain code:code userInfo:userInfo];
}

@end

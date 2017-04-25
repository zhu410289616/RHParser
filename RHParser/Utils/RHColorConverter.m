//
//  RHColorConverter.m
//  RHLabel
//
//  Created by zhuruhong on 2017/4/15.
//  Copyright © 2017年 zhuruhong. All rights reserved.
//

#import "RHColorConverter.h"

@implementation RHColorConverter

+ (instancetype)sharedInstance
{
    static RHColorConverter *gColorConverter = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        gColorConverter = [[self alloc] init];
    });
    return gColorConverter;
}

- (UIColor *)colorWithString:(NSString *)inString error:(NSError *__autoreleasing *)outError
{
    NSString *theString = [[inString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    if ([theString hasPrefix:@"0X"]) {
        theString = [theString substringFromIndex:2];
    } else if ([theString hasPrefix:@"#"]) {
        theString = [theString substringFromIndex:1];
    }
    
    if (theString.length < 6) {
        *outError = [NSError errorWithDomain:@"RHColorConverter" code:-1 userInfo:nil];
        return [UIColor redColor];
    }
    
    // Separate into r, g, b substrings
    NSRange range;
    range.length = 2;
    range.location = 0;
    NSString *rString = [theString substringWithRange:range];
    
    range.location = 2;
    NSString *gString = [theString substringWithRange:range];
    
    range.location = 4;
    NSString *bString = [theString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f)
                           green:((float) g / 255.0f)
                            blue:((float) b / 255.0f)
                           alpha:1.0f];
}

@end

#pragma mark -

@implementation UIColor (RHColorConverter)

+ (UIColor *)colorWithHexString:(NSString *)inHexString
{
    return [[RHColorConverter sharedInstance] colorWithString:inHexString error:nil];
}

@end

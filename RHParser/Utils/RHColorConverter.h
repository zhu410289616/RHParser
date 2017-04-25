//
//  RHColorConverter.h
//  RHLabel
//
//  Created by zhuruhong on 2017/4/15.
//  Copyright © 2017年 zhuruhong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface RHColorConverter : NSObject

+ (instancetype)sharedInstance;

- (UIColor *)colorWithString:(NSString *)inString error:(NSError **)outError;

@end

#pragma mark -

@interface UIColor (RHColorConverter)

+ (UIColor *)colorWithHexString:(NSString *)inHexString;

@end

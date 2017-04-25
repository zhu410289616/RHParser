//
//  RHHtmlParser.h
//  Example
//
//  Created by zhuruhong on 2017/4/19.
//  Copyright © 2017年 zhuruhong. All rights reserved.
//

#import "RHParser.h"

/**
 * 解析html字符串
 * 1-Build Phases中，在Link Binary With Libraries中加入libxml库
 * 2-Build Settings中，在Header Search Paths中加入/usr/include/libxml2
 */
@interface RHHtmlParser : RHParser

@end

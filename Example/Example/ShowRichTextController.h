//
//  ShowRichTextController.h
//  Example
//
//  Created by zhuruhong on 2017/5/10.
//  Copyright © 2017年 zhuruhong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShowRichTextController : UIViewController

@property (nonatomic, strong) NSString *richText;
/** 0-普通字符串展示，1-html解析展示，2-xml解析展示 */
@property (nonatomic, assign) NSInteger textType;

@end

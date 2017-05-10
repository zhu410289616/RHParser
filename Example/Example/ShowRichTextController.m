//
//  ShowRichTextController.m
//  Example
//
//  Created by zhuruhong on 2017/5/10.
//  Copyright © 2017年 zhuruhong. All rights reserved.
//

#import "ShowRichTextController.h"
#import "RHHtmlParser.h"
#import "RHXmlParser.h"

@interface ShowRichTextController ()

@property (nonatomic, strong) UITextView *textView;

@end

@implementation ShowRichTextController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _textView = [[UITextView alloc] init];
    _textView.frame = self.view.bounds;
    _textView.font = [UIFont systemFontOfSize:12];
    _textView.textColor = [UIColor grayColor];
    [self.view addSubview:_textView];
    
    NSAttributedString *attributedString = nil;
    if (0 == _textType) {
        attributedString = [[NSAttributedString alloc] initWithString:_richText];
    } else if (1 == _textType) {
        RHHtmlParser *htmlParser = [[RHHtmlParser alloc] init];
        attributedString = [htmlParser parseString:_richText filter:nil];
    } else if (2 == _textType) {
        RHXmlParser *xmlParser = [[RHXmlParser alloc] init];
        attributedString = [xmlParser parseString:_richText filter:nil];
    }
    _textView.attributedText = attributedString;
}

@end

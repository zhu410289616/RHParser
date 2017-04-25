//
//  ViewController.m
//  Example
//
//  Created by zhuruhong on 2017/4/19.
//  Copyright © 2017年 zhuruhong. All rights reserved.
//

#import "ViewController.h"
#import "UILabel+RHExtensions.h"

#import "RHHtmlParser.h"
#import "RHXmlParser.h"

@interface ViewController ()

@property (nonatomic, strong) UILabel *htmlLabel;
@property (nonatomic, strong) UITextView *htmlTextView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSString *htmlString = @"<font color='#00ff00' bgcolor='#fa8919'>bai<font size='24' color='#ff00ff'>This <strike>is aaa</strike> some text!</font>bai</font><font color='#000000'>价格：</font><font color='#00ffff'>33.4</font><font color='#00ff00'>bai<font size='24' color='#ff00ff'>This <strike>is aaa</strike> some text!</font>bai</font><font color='#000000'>价格：</font><font color='#00ffff'>33.4</font><img src='www.baidu.com'><a href='https://www.baidu.com/img/bd_logo1.png'><img src='https://www.baidu.com/img/bd_logo1.png'></a><p>pppp</p><image src=\"item_72_s_122010.png\"/>item_72_s_122010</image><p>哈哈哈<font color=\"#fa8919\" size=\"58\">43333333</font>我是置顶消息摘要－消息<font color=\"#345643\" size=\"34\">（二）消息</font>dfs太容易让他的身份<font size=\"12\">发生地方</font>卡上开发的乐山大佛</p><img src='item_67_s_122010.png' width='60' height='65'>item_67_s_122010.png</img> <p>title<span>111</span><a href=\"https://www.baidu.com\">222</a>333<br><i>77&nbsp;7<strong>555</strong>444</i>666</p><strike> strike </strike> <stroke>stroke</stroke> <img src=\"item_72_s_122010.png\" width='60' height='65'><img src=\"item_72_s_122010.png\" width='60' height='65'>岁地方";
    
    RHHtmlParser *htmlParser = [[RHHtmlParser alloc] init];
    NSAttributedString *attributedString = [htmlParser parseString:htmlString filter:nil error:nil];
    
    NSString *xmlPath = [[NSBundle mainBundle] pathForResource:@"XmlTest" ofType:@"xml"];
    NSData *xmlData = [NSData dataWithContentsOfFile:xmlPath];
    NSString *xmlString = [NSString stringWithUTF8String:(char *)xmlData.bytes];
    RHXmlParser *xmlParser = [[RHXmlParser alloc] init];
    NSError *error = nil;
    [xmlParser parseString:xmlString filter:nil error:&error];
    
    _htmlTextView = [[UITextView alloc] init];
    _htmlTextView.frame = CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 200);
    _htmlTextView.font = [UIFont systemFontOfSize:12];
    _htmlTextView.textColor = [UIColor brownColor];
    _htmlTextView.attributedText = attributedString;
    [self.view addSubview:_htmlTextView];
    
    _htmlLabel = [[UILabel alloc] init];
    _htmlLabel.frame = CGRectMake(0, 90, CGRectGetWidth(self.view.frame), 500);
    _htmlLabel.font = [UIFont systemFontOfSize:12];
    _htmlLabel.textColor = [UIColor grayColor];
    _htmlLabel.numberOfLines = 0;
    [_htmlLabel setHtmlText:htmlString];
    [self.view addSubview:_htmlLabel];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

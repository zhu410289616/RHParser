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

#import "RHNode.h"

#import "ShowRichTextController.h"

@interface ViewController ()

@property (nonatomic, strong) UIButton *testButton;
@property (nonatomic, strong) UIButton *htmlButton;
@property (nonatomic, strong) UIButton *xmlButton;

@property (nonatomic, strong) UILabel *htmlLabel;
@property (nonatomic, strong) UILabel *xmlLabel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    _testButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _testButton.frame = CGRectMake(20, 80, 100, 45);
    [_testButton setTitle:@"test" forState:UIControlStateNormal];
    [_testButton setBackgroundColor:[UIColor redColor]];
    [_testButton addTarget:self action:@selector(doTestButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_testButton];
    
    _htmlButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _htmlButton.frame = CGRectMake(20, CGRectGetMaxY(_testButton.frame)+5, 100, 45);
    [_htmlButton setTitle:@"html" forState:UIControlStateNormal];
    [_htmlButton setBackgroundColor:[UIColor redColor]];
    [_htmlButton addTarget:self action:@selector(doHtmlButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_htmlButton];
    
    _xmlButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _xmlButton.frame = CGRectMake(20, CGRectGetMaxY(_htmlButton.frame)+5, 100, 45);
    [_xmlButton setTitle:@"xml" forState:UIControlStateNormal];
    [_xmlButton setBackgroundColor:[UIColor redColor]];
    [_xmlButton addTarget:self action:@selector(doXmlButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_xmlButton];
    
    NSString *htmlString = @"<username>我是username自定义样式</username><password size='20'>我是password自定义样式，注意属性内容</password><font color='#00ff00' bgcolor='#fa8919'>bai<font size='24' color='#ff00ff'>This <strike>is aaa</strike> some text!</font>bai</font><font color='#000000'>价格：</font><font color='#00ffff'>33.4</font><font color='#00ff00'>bai<font size='24' color='#ff00ff'>This <strike>is aaa</strike> some text!</font>bai</font><font color='#000000'>价格：</font><font color='#00ffff'>33.4</font><img src='www.baidu.com'><a href='https://www.baidu.com/img/bd_logo1.png'><img src='https://www.baidu.com/img/bd_logo1.png'></a><p>pppp</p><p>哈哈哈<font color=\"#fa8919\" size=\"58\">43333333</font>我是置顶消息摘要－消息<font color=\"#345643\" size=\"34\">（二）消息</font><font size=\"12\">dfs太容易让他的身份发生地方</font>卡上开发的乐山大佛</p><img src='item_67_s_122010.png' width='60' height='65'> <p>title<span>111</span><a href=\"https://www.baidu.com\">222</a>333<br><i>77&nbsp;7<strong>555</strong>444</i>666</p><strike> strike </strike> <stroke>stroke</stroke> <img src=\"item_72_s_122010.png\" width='60' height='65'><img src=\"item_72_s_122010.png\" width='60' height='65'>岁地方";
    
    RHHtmlParser *htmlParser = [[RHHtmlParser alloc] init];
    
    //自定义样式
    NSDictionary *customStyles = @{
                                   NSForegroundColorAttributeName: [UIColor orangeColor],
                                   NSBackgroundColorAttributeName: [UIColor blueColor]
                                   };
    [htmlParser addStyle:customStyles forTag:@"username"];
    
    [htmlParser addNodeBlock:^NSAttributedString *(RHNode *node, NSDictionary *defaultStyles) {
        NSString *theContent = node.content ?: @"";
        
        NSString *theSizeString = node.attributes[@"size"];
        NSDictionary *theStyle = @{
                                   NSForegroundColorAttributeName: [UIColor redColor],
                                   NSFontAttributeName: [UIFont systemFontOfSize:[theSizeString floatValue]]
                                   };
        
        NSAttributedString *theAttributedString = [[NSAttributedString alloc] initWithString:theContent attributes:theStyle];
        
        return theAttributedString;
    } forTag:@"password"];
    
    NSAttributedString *attributedString = [htmlParser parseString:htmlString filter:nil];
    
    _htmlLabel = [[UILabel alloc] init];
    _htmlLabel.frame = CGRectMake(0, CGRectGetMaxY(_xmlButton.frame), CGRectGetWidth(self.view.frame), 300);
    _htmlLabel.font = [UIFont systemFontOfSize:12];
    _htmlLabel.textColor = [UIColor grayColor];
    _htmlLabel.numberOfLines = 0;
    _htmlLabel.attributedText = attributedString;
//    [_htmlLabel setHtmlText:htmlString];
    [self.view addSubview:_htmlLabel];
    
    //
    NSString *xmlPath = [[NSBundle mainBundle] pathForResource:@"XmlTest" ofType:@"xml"];
    NSData *xmlData = [NSData dataWithContentsOfFile:xmlPath];
    NSString *xmlString = [NSString stringWithUTF8String:(char *)xmlData.bytes];
    RHXmlParser *xmlParser = [[RHXmlParser alloc] init];
    attributedString = [xmlParser parseString:xmlString filter:nil];
    
    _xmlLabel = [[UILabel alloc] init];
    _xmlLabel.frame = CGRectMake(0, CGRectGetMaxY(_htmlLabel.frame), CGRectGetWidth(self.view.frame), 160);
    _xmlLabel.font = [UIFont systemFontOfSize:12];
    _xmlLabel.textColor = [UIColor grayColor];
    _xmlLabel.numberOfLines = 0;
    _xmlLabel.attributedText = attributedString;
    [self.view addSubview:_xmlLabel];
}


- (void)doTestButtonAction
{
    NSString *htmlString = @"<font color='#00ff00' bgcolor='#fa8919'>bai<font size='24' color='#ff00ff'>This <strike>is aaa</strike> some text!</font>bai</font><font color='#000000'>价格：</font><font color='#00ffff'>33.4</font>岁地方";
    ShowRichTextController *vc = [[ShowRichTextController alloc] init];
    vc.richText = htmlString;
    vc.textType = 0;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)doHtmlButtonAction
{
    NSString *htmlString = @"<font color='#00ff00' bgcolor='#fa8919'>bai<font size='24' color='#ff00ff'>This <strike>is aaa</strike> some text!</font>bai</font><font color='#000000'>价格：</font><font color='#00ffff'>33.4</font><font color='#00ff00'>bai<font size='24' color='#ff00ff'>This <strike>is aaa</strike> some text!</font>bai</font><font color='#000000'>价格：</font><font color='#00ffff'>33.4</font><img src='www.baidu.com'><a href='https://www.baidu.com/img/bd_logo1.png'><img src='https://www.baidu.com/img/bd_logo1.png'></a><p>pppp</p><p>哈哈哈<font color=\"#fa8919\" size=\"58\">43333333</font>我是置顶消息摘要－消息<font color=\"#345643\" size=\"34\">（二）消息</font><font size=\"12\">dfs太容易让他的身份发生地方</font>卡上开发的乐山大佛</p><img src='item_67_s_122010.png' width='60' height='65'> <p>title<span>111</span><a href=\"https://www.baidu.com\">222</a>333<br><i>77&nbsp;7<strong>555</strong>444</i>666</p><strike> strike </strike> <stroke>stroke</stroke> <img src=\"item_72_s_122010.png\" width='60' height='65'><img src=\"item_72_s_122010.png\" width='60' height='65'>岁地方";
    ShowRichTextController *vc = [[ShowRichTextController alloc] init];
    vc.richText = htmlString;
    vc.textType = 1;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)doXmlButtonAction
{
    NSString *xmlPath = [[NSBundle mainBundle] pathForResource:@"XmlTest" ofType:@"xml"];
    NSData *xmlData = [NSData dataWithContentsOfFile:xmlPath];
    NSString *xmlString = [NSString stringWithUTF8String:(char *)xmlData.bytes];
    
    ShowRichTextController *vc = [[ShowRichTextController alloc] init];
    vc.richText = xmlString;
    vc.textType = 2;
    [self.navigationController pushViewController:vc animated:YES];
}

@end

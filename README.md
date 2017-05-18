# RHParser
html、xml等标记语言解析。可以方便的转换为NSAttributedString。

### 把html转换为NSAttributedString
	NSString *htmlString = @"<font color=\"#fa8919\" size='58'>43333333</font>";
	RHHtmlParser *htmlParser = [[RHHtmlParser alloc] init];
	NSAttributedString *attributedString = [htmlParser parseString:htmlString filter:nil];

### 自定义样式
	NSString *htmlString = @"<username>我是username自定义样式</username><password size='20'>我是password自定义样式，注意属性内容</password>";
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




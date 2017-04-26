//
//  RHXmlParser.m
//  Example
//
//  Created by zhuruhong on 2017/4/25.
//  Copyright © 2017年 zhuruhong. All rights reserved.
//

#import "RHXmlParser.h"
#import "RHNodeList.h"
#import "RHXmlNodeFilter.h"
#import "RHNode.h"
#import "RHColorConverter.h"

@interface RHXmlParser () <NSXMLParserDelegate>

@property (nonatomic, strong) RHNodeList *nodeList;
@property (nonatomic, strong) RHNodeFilter *filter;
@property (nonatomic, strong) RHNode *currentNode;

@end

@implementation RHXmlParser

- (instancetype)init
{
    if (self = [super init]) {
        _nodeList = [[RHNodeList alloc] init];
        _filter = [[RHXmlNodeFilter alloc] init];
        [self setStyles];
        [self setNodeBlocks];
    }
    return self;
}

- (void)setStyles
{
    NSDictionary *theStyleAttribute = nil;
    
    //a
    theStyleAttribute = @{ NSForegroundColorAttributeName: [UIColor blueColor],
                           NSUnderlineStyleAttributeName: @(NSUnderlineStyleSingle),
                           NSUnderlineColorAttributeName: [UIColor redColor] };
    [self addStyle:theStyleAttribute forTag:@"a"];
    
    //strong 加粗
    theStyleAttribute = @{ NSExpansionAttributeName: @(0.9) };
    [self addStyle:theStyleAttribute forTag:@"strong"];
    
    //mark
    theStyleAttribute = @{ NSForegroundColorAttributeName: [UIColor yellowColor] };
    [self addStyle:theStyleAttribute forTag:@"mark"];
    
    //i 斜体
    theStyleAttribute = @{ NSBackgroundColorAttributeName: [UIColor yellowColor],
                           NSForegroundColorAttributeName: [UIColor redColor],
                           NSObliquenessAttributeName: @(2) };
    [self addStyle:theStyleAttribute forTag:@"i"];
    
    //strike 删除线
    theStyleAttribute = @{ NSStrikethroughStyleAttributeName: @(NSUnderlineStyleSingle),
                           NSStrikethroughColorAttributeName: [UIColor greenColor] };
    [self addStyle:theStyleAttribute forTag:@"strike"];
    
    //stroke 描边
    theStyleAttribute = @{ NSStrokeColorAttributeName: [UIColor redColor],
                           NSStrokeWidthAttributeName: @(2) };
    [self addStyle:theStyleAttribute forTag:@"stroke"];
}

- (void)setNodeBlocks
{
    RHNodeBlock theNodeBlock = nil;
    __weak typeof(self) weakSelf = self;
    
    //img
    theNodeBlock = ^(RHNode *node, NSDictionary *defaultStyles) {
        NSString *theSrcString = node.attributes[@"src"];
        UIImage *theImage = (theSrcString.length > 0) ? [UIImage imageNamed:theSrcString] : nil;
        
        NSString *theWidthString = node.attributes[@"width"];
        NSString *theHeightString = node.attributes[@"height"];
        CGRect bounds = CGRectZero;
        if (theWidthString.length > 0 && theHeightString.length > 0) {
            bounds.size.width = [theWidthString floatValue];
            bounds.size.height = [theHeightString floatValue];
        }
        
        NSTextAttachment *theTextAttachment = [[NSTextAttachment alloc] init];
        theTextAttachment.image = theImage;
        if (bounds.size.width > 2 && bounds.size.height > 2) {
            theTextAttachment.bounds = bounds;
        }
        NSAttributedString *theAttributedString = [NSAttributedString attributedStringWithAttachment:theTextAttachment];
        
        return theAttributedString;
    };
    [self addNodeBlock:theNodeBlock forTag:@"img"];
    
    //a
    theNodeBlock = ^(RHNode *node, NSDictionary *defaultStyles) {
        NSString *theContent = node.content ?: @"???";
        
        NSMutableDictionary *theStyle = [NSMutableDictionary dictionary];
        if (defaultStyles.count > 0) {
            [theStyle addEntriesFromDictionary:defaultStyles];
        }
        NSString *theHrefString = node.attributes[@"href"];
        if (theHrefString.length > 0) {
            theStyle[NSLinkAttributeName] = [NSURL URLWithString:theHrefString];
        }
        NSAttributedString *theAttributedString = [[NSAttributedString alloc] initWithString:theContent attributes:theStyle];
        
        return theAttributedString;
    };
    [self addNodeBlock:theNodeBlock forTag:@"a"];
    
    //font
    theNodeBlock = ^(RHNode *node, NSDictionary *defaultStyles) {
        NSString *theContent = node.content ?: @"";
        
        NSMutableDictionary *theStyle = [NSMutableDictionary dictionary];
        if (defaultStyles.count > 0) {
            [theStyle addEntriesFromDictionary:theStyle];
        }
        
        NSString *theColorString = node.attributes[@"color"];
        if (theColorString.length > 0) {
            UIColor *theColor = [UIColor colorWithHexString:theColorString];
            theStyle[NSForegroundColorAttributeName] = theColor;
        }
        
        NSString *theBgColorString = node.attributes[@"bgcolor"];
        if (theBgColorString.length > 0) {
            UIColor *theBgColor = [UIColor colorWithHexString:theBgColorString];
            theStyle[NSBackgroundColorAttributeName] = theBgColor;
        }
        
        NSString *theSizeString = node.attributes[@"size"];
        if (theSizeString.length > 0) {
            NSDictionary *styleDic = weakSelf.stylesMap[@"font"];
            UIFont *styleFont = styleDic[NSFontAttributeName];
            theStyle[NSFontAttributeName] = [UIFont fontWithName:styleFont.fontName size:[theSizeString floatValue]];
        }
        NSAttributedString *theAttributedString = [[NSAttributedString alloc] initWithString:theContent attributes:theStyle];
        
        return theAttributedString;
    };
    [self addNodeBlock:theNodeBlock forTag:@"font"];
}

#pragma mark - NSXMLParserDelegate

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary<NSString *,NSString *> *)attributeDict
{
    RHParserLog(@"start elementName: %@, namespaceURI: %@, qName: %@, attributeDict: %@", elementName, namespaceURI, qName, attributeDict);
    
    _currentNode = [[RHNode alloc] init];
    _currentNode.name = elementName;
    [_currentNode addAttributes:@{@"tag":elementName}];
    [_currentNode addAttributes:attributeDict];
    
    if (![_filter filter:_currentNode]) {
        [_nodeList addNode:_currentNode];
    }
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    RHParserLog(@"end elementName: %@, namespaceURI: %@, qName: %@", elementName, namespaceURI, qName);
    _currentNode = nil;
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    RHParserLog(@"string: %@", string);
    _currentNode.content = string;
}

#pragma mark - public

- (RHNodeList *)nodeListWithString:(NSString *)inString filter:(RHNodeFilter *)inFilter
{
    if (inString.length == 0) {
        return nil;
    }
    
    NSData *theData = [inString dataUsingEncoding:NSUTF8StringEncoding];
    NSXMLParser *xmlParser = [[NSXMLParser alloc] initWithData:theData];
    xmlParser.delegate = self;
    xmlParser.shouldProcessNamespaces = NO;
    xmlParser.shouldReportNamespacePrefixes = NO;
    xmlParser.shouldResolveExternalEntities = NO;
    [xmlParser parse];
    
    return _nodeList;
}

- (NSAttributedString *)parseString:(NSString *)inString filter:(RHNodeFilter *)inFilter
{
    RHNodeList *theNodeList = [self nodeListWithString:inString filter:inFilter];
    
    NSMutableAttributedString *theAttrString = [[NSMutableAttributedString alloc] init];
    for (RHNode *node in theNodeList.nodes) {
        RHParserLog(@"name: %@, content: %@, attributes: %@", node.name, node.content, node.attributes);
        
        NSString *tag = node.attributes[@"tag"];
        if (tag.length == 0) {
            continue;
        }
        
        NSString *content = node.content;
        NSDictionary *baseAttributes = self.stylesMap[tag];
        RHNodeBlock nodeBlock = self.nodeBlocksMap[tag];
        
        NSAttributedString *nodeAttrStr = nil;
        if (nodeBlock) {
            nodeAttrStr = nodeBlock(node, baseAttributes);
        } else if (content.length > 0) {
            nodeAttrStr = [[NSAttributedString alloc] initWithString:content attributes:baseAttributes];
        }
        
        if (nodeAttrStr) {
            [theAttrString appendAttributedString:nodeAttrStr];
        }
    }
    
    return theAttrString;
}

@end

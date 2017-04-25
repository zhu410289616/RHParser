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

NSString * const RHXmlParserDomain = @"RHXmlParserDomain";

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
    }
    return self;
}

#pragma mark - NSXMLParserDelegate

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary<NSString *,NSString *> *)attributeDict
{
    NSLog(@"start elementName: %@, namespaceURI: %@, qName: %@, attributeDict: %@", elementName, namespaceURI, qName, attributeDict);
    _currentNode = [[RHNode alloc] init];
    _currentNode.name = elementName;
    [_currentNode addAttributes:@{@"tag":elementName}];
    
    if ([_filter filter:_currentNode]) {
        _currentNode = nil;
    }
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    NSLog(@"end elementName: %@, namespaceURI: %@, qName: %@", elementName, namespaceURI, qName);
    if (_currentNode) {
        [_nodeList addNode:_currentNode];
    }
    _currentNode = nil;
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    NSLog(@"string: %@", string);
    _currentNode.content = string;
}

#pragma mark - public

- (RHNodeList *)nodeListWithString:(NSString *)inString filter:(RHNodeFilter *)inFilter error:(NSError **)outError
{
    NSLog(@"inString: %@", inString);
    if (inString.length == 0) {
        NSDictionary *userInfo = @{ NSLocalizedDescriptionKey:@"inString is nil" };
        *outError = [self errorWithCode:1 UserInfo:userInfo];
        return nil;
    }
    
    NSData *theData = [inString dataUsingEncoding:NSUTF8StringEncoding];
    NSXMLParser *xmlParser = [[NSXMLParser alloc] initWithData:theData];
    xmlParser.delegate = self;
    xmlParser.shouldProcessNamespaces = NO;
    xmlParser.shouldReportNamespacePrefixes = NO;
    xmlParser.shouldResolveExternalEntities = NO;
    [xmlParser parse];
//    if (xmlParser.parserError) {
//        *outError = *outError ? xmlParser.parserError : nil;
//        return nil;
//    }
    
    return _nodeList;
}

- (NSAttributedString *)parseString:(NSString *)inString filter:(RHNodeFilter *)inFilter error:(NSError **)outError
{
    RHNodeList *theNodeList = [self nodeListWithString:inString filter:inFilter error:outError];
    if (*outError) {
        return nil;
    }
    
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

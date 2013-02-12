//
//  Parser.m
//  mtGuide
//
//  Created by Hisatomi Yasushi on 13/01/25.
//  Copyright (c) 2013年 hisatomiyasushi. All rights reserved.
//

#import "Parser.h"
#import "InfoDetailViewController.h"
#import "AppDelegate.h"

@implementation Parser

- (id) initParser {
    if (self == [super init]) {
        
        app = (AppDelegate *)[[UIApplication sharedApplication]delegate];
        
    }
    return self;
}

- (void) parserDidStartDocument:(NSXMLParser *)parser {
    
    app.gaiyouStr = @"";
    
}
- (void) parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict {
    
    //開始タグが"text"だったら
    if ([elementName isEqualToString:@"text"]) {
        //解析タグに設定
        app.gaiyouStr = [[NSString stringWithString:elementName];
        app.txtBuffer = @"";
        
    }

}

-(void) parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    
    
    
    
}

- (void) parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    
    
    
}


@end

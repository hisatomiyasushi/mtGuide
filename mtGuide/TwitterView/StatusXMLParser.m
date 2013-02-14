//
//  StatusXMLParser.m
//  mtGuide
//
//  Created by Hisatomi Yasushi on 13/02/13.
//  Copyright (c) 2013年 hisatomiyasushi. All rights reserved.
//

#import "StatusXMLParser.h"

@implementation StatusXMLParser

@synthesize currentXpath;
@synthesize statuses;
@synthesize currentStatus;
@synthesize textNodeCharacters;

// （9）
- (void) parserDidStartDocument:(NSXMLParser *)parser {
    self.currentXpath = [[NSMutableString alloc]init];
    self.statuses = [[NSMutableArray alloc] init];
}

// （10）
- (void) parser:(NSXMLParser *)parser
didStartElement:(NSString *)elementName
   namespaceURI:(NSString *)namespaceURI
  qualifiedName:(NSString *)qName
     attributes:(NSDictionary *)attributeDict {
    [self.currentXpath appendString: elementName];
    [self.currentXpath appendString: @"/"];
    
    self.textNodeCharacters = [[NSMutableString alloc] init];
    
    if ([self.currentXpath isEqualToString: @"statuses/status/"]) {
        self.currentStatus = [[NSMutableDictionary alloc] init];
    }
}

// （11）
- (void) parser:(NSXMLParser *)parser
  didEndElement:(NSString *)elementName
   namespaceURI:(NSString *)namespaceURI
  qualifiedName:(NSString *)qName {
    
    NSString *textData = [self.textNodeCharacters stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    if ([self.currentXpath isEqualToString: @"statuses/status/"]) {
        [self.statuses addObject:self.currentStatus];
        self.currentStatus = nil;
        
    } else if ([self.currentXpath isEqualToString: @"statuses/status/text/"]) {
        [self.currentStatus setValue:textData forKey:@"text"];
        
    } else if ([self.currentXpath isEqualToString: @"statuses/status/user/name/"]) {
        [self.currentStatus setValue:textData forKey:@"name"];
    }
    
    int delLength = [elementName length] + 1;
    int delIndex = [self.currentXpath length] - delLength;
    
    [self.currentXpath deleteCharactersInRange:NSMakeRange(delIndex,delLength)];
}

// （12）
- (void) parser:(NSXMLParser *)parser
foundCharacters:(NSString *)string {
    [self.textNodeCharacters appendString:string];
}

// （13）
- (NSArray *) parseStatuses:(NSData *)xmlData {
    NSXMLParser *parser = [[NSXMLParser alloc] initWithData:xmlData];
    [parser setDelegate:self];
    [parser parse];
    
    return self.statuses;
}

- (void)parserDidEndDocument:(NSXMLParser *)parser {
	NSLog(@"解析が完了しました");
    
}

@end

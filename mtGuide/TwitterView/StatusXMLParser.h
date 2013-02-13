//
//  StatusXMLParser.h
//  mtGuide
//
//  Created by Hisatomi Yasushi on 13/02/13.
//  Copyright (c) 2013年 hisatomiyasushi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StatusXMLParser : NSObject<NSXMLParserDelegate> {
    NSMutableString *currentXpath;
    NSMutableArray *statuses;
    NSMutableDictionary *currentStatus;
    NSMutableString *textNodeCharacters;
}

@property (retain , nonatomic) NSMutableString *currentXpath;
@property (retain , nonatomic) NSMutableArray *statuses;
@property (retain , nonatomic) NSMutableDictionary *currentStatus;
@property (retain , nonatomic) NSMutableString *textNodeCharacters;

- (NSArray *) parseStatuses: (NSData *) xmlData;

@end
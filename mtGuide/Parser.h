//
//  Parser.h
//  mtGuide
//
//  Created by Hisatomi Yasushi on 13/01/25.
//  Copyright (c) 2013年 hisatomiyasushi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppDelegate.h"
#import "List.h"

@interface Parser : NSObject<NSXMLParserDelegate> {
    
    AppDelegate *app;
    List *theList;
    NSMutableString *currentElementValue;

}

- (id)initParser;


@end

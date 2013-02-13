//
//  URLLoder.h
//  mtGuide
//
//  Created by Hisatomi Yasushi on 13/02/13.
//  Copyright (c) 2013年 hisatomiyasushi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface URLLoader : NSObject{
    NSURLConnection *connection;
    NSMutableData   *data;
}

@property(retain, nonatomic) NSURLConnection *connection;
@property(retain ,nonatomic) NSMutableData *data;

- (void) loadFromUrl: (NSString *)url method:(NSString *) method;

@end
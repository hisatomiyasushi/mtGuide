//
//  FlickrPhotoParser.h
//  mtGuide
//
//  Created by Hisatomi Yasushi on 13/01/19.
//  Copyright (c) 2013年 hisatomiyasushi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Photo.h"

@interface FlickrPhotoParser : NSObject <NSXMLParserDelegate>  {
    NSMutableArray *list;
}

@property (nonatomic, retain) NSMutableArray *list;

- (NSArray*) fetchNearbyPhotos: (CLLocationCoordinate2D) centerCoordinate;

@end

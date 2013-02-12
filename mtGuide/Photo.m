//
//  Photo.m
//  mtGuide
//
//  Created by Hisatomi Yasushi on 13/01/19.
//  Copyright (c) 2013年 hisatomiyasushi. All rights reserved.
//

#import "Photo.h"

@implementation Photo

@synthesize title,
            coordinate,
            owner,
            ownerName,
            photoId,
            thumbUrl;

- (void)setCoordinate:(CLLocationCoordinate2D)newCoordinate {
    coordinate = newCoordinate;
}
- (NSString *)title {
    return title;
}
- (NSString *)subtitle {
    return ownerName;
}

- (NSString *) url { //……【1】
    return [NSString stringWithFormat:@"http://www.flickr.com/photos/%@/%@",
            owner, photoId];
}

@end

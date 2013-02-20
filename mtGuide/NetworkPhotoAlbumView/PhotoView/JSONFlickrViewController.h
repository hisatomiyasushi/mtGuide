//
//  JSONFlickrViewController.h
//  mtGuide
//
//  Created by Hisatomi Yasushi on 13/01/30.
//  Copyright (c) 2013年 hisatomiyasushi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "NetworkPhotoAlbumViewController.h"

@interface JSONFlickrViewController : NetworkPhotoAlbumViewController

- (id)initWith:(id)object;

@property (nonatomic, readwrite, copy) NSString* flickrAlbumId;
@property (nonatomic, retain) NSDictionary *mtItem;

@end

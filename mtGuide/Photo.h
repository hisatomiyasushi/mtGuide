//
//  Photo.h
//  mtGuide
//
//  Created by Hisatomi Yasushi on 13/01/19.
//  Copyright (c) 2013年 hisatomiyasushi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>

@interface Photo : NSObject <MKAnnotation> {
    NSString *title; //写真のタイトル
    CLLocationCoordinate2D coordinate; //座標
    NSString *owner; //投稿者ーナーID
    NSString *ownerName; //投稿者名
    NSString *photoId; //写真のID
    NSString *thumbUrl; //サムネイル画像のURL
}

@property (nonatomic, retain) NSString *title;
@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;
@property (nonatomic, retain) NSString *owner;
@property (nonatomic, retain) NSString *ownerName;
@property (nonatomic, retain) NSString *photoId;
@property (nonatomic, retain) NSString *thumbUrl;

- (void)setCoordinate:(CLLocationCoordinate2D)newCoordinate;
- (NSString *)title;
- (NSString *)subtitle;
- (NSString *) url ;

@end

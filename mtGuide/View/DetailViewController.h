//
//  DetailViewController.h
//  mtGuide
//
//  Created by Hisatomi Yasushi on 13/01/10.
//  Copyright (c) 2013年 hisatomiyasushi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "TileOverlay.h"

@class WeatherSubViewController;
@class CheckSubViewController;
@class StatsSubViewController;

@interface DetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;
@property (nonatomic, retain) NSDictionary *mtItem;
@property (nonatomic, retain) NSArray *detailData;
@property (weak, nonatomic) IBOutlet UILabel *twitterLabel;
@property (weak, nonatomic) IBOutlet UITextView *twitterTextView;
@property(retain, nonatomic) NSArray *statuses;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@end

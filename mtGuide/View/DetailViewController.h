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

@interface DetailViewController : UIViewController<UITableViewDataSource, UITableViewDelegate, MKMapViewDelegate, CLLocationManagerDelegate>


//@property (strong, nonatomic) id detailItem;
@property (nonatomic, retain) NSDictionary *mtItem;
@property (nonatomic, retain) NSArray *detailData;
//@property (weak, nonatomic) IBOutlet UILabel *twitterLabel;
//@property (weak, nonatomic) IBOutlet UIImageView *mainImageView;
//@property (weak, nonatomic) IBOutlet UITextView *twitterTextView;
@property(retain, nonatomic) NSArray *statuses;
//@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
//@property (weak, nonatomic) IBOutlet MKMapView *detailMapView;
//@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
@property (weak, nonatomic) IBOutlet UITableView *detailTableView;
//@property (weak, nonatomic) IBOutlet UISegmentedControl *detailsegmentedcontrol;
@property (nonatomic, retain) TileOverlay *overlay;

//- (IBAction)segmentedValueChanged:(UISegmentedControl *)sender;
//- (IBAction)mtButton:(id)sender;
//- (IBAction)weButton:(id)sender;
//- (IBAction)ckButton:(id)sender;
//- (IBAction)stButton:(id)sender;

@end

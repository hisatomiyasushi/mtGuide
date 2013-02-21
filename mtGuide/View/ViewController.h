//
//  ViewController.h
//  mtGuide
//
//  Created by Hisatomi Yasushi on 13/01/09.
//  Copyright (c) 2013年 hisatomiyasushi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>


@interface ViewController : UIViewController<UITableViewDataSource, UITableViewDelegate, MKMapViewDelegate, CLLocationManagerDelegate>

@property (weak, nonatomic) IBOutlet UITableView *myTableView;
@property (weak, nonatomic) IBOutlet MKMapView *myMapView;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedcontrol;
@property (weak, nonatomic) IBOutlet UIButton *favMapButton;
- (IBAction)segmentedValueChanged:(UISegmentedControl *)sender;
- (IBAction)favMapButtonDidTouch:(id)sender;

@end

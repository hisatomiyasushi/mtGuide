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
#import <Foundation/Foundation.h>


@interface ViewController : UIViewController<UITableViewDataSource, UITableViewDelegate,MKMapViewDelegate, CLLocationManagerDelegate>
{
    IBOutlet UISegmentedControl *segmentedcontrol;
    NSArray *myregKeys;
    NSDictionary *mydataSource;
}

@property (weak, nonatomic) IBOutlet UITableView *myTableView;
@property (weak, nonatomic) IBOutlet MKMapView *myMapView;

- (IBAction)segmentedValueChanged:(UISegmentedControl *)sender;

 
@end

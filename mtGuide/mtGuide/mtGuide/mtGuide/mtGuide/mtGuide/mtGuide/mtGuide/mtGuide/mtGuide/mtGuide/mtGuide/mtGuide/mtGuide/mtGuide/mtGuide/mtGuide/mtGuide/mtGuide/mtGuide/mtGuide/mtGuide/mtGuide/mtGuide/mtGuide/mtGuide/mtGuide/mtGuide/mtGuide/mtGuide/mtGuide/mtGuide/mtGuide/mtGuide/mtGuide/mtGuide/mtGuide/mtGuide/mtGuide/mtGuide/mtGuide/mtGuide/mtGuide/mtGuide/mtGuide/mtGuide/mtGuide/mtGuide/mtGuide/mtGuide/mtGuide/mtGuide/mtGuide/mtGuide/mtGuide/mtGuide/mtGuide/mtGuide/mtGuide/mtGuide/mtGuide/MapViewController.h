//
//  MapViewController.h
//  mtGuide
//
//  Created by Hisatomi Yasushi on 13/01/09.
//  Copyright (c) 2013年 hisatomiyasushi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "ViewController.h"

@interface MapViewController : UIViewController<MKMapViewDelegate> {
    
    IBOutlet MKMapView *myView;
    IBOutlet UISegmentedControl *segmentedcontrol;
    
}

- (IBAction)segmentSwitch2:(id)sender;


@end

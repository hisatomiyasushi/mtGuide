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


//文字データを入れる変数を作る
@interface DetailViewController : UIViewController<UITableViewDataSource, UITableViewDelegate, MKMapViewDelegate, CLLocationManagerDelegate>
{
    NSString *mtStr;
    NSString *introStr;
    NSString *mtInformation;
    NSString *mtlatStr;
    NSString *mtlngStr;
    NSString *yomiStr;
    NSArray *mttrails;
    NSArray *mtcamping;
    NSArray *detailData;
    IBOutlet UISegmentedControl *detailsegmentedcontrol;
}

@property (strong, nonatomic) id detailItem;
@property (nonatomic, retain) NSString *mtStr;
@property (nonatomic, retain) NSString *introStr;
@property (nonatomic, retain) NSString *mtInformation;
@property (nonatomic, retain) NSString *yomiStr;
@property (nonatomic, retain) NSString *mtlatStr;
@property (nonatomic, retain) NSString *mtlngStr;
@property (nonatomic, retain) NSArray *mttrails;
@property (nonatomic, retain) NSArray *mtcamping;
@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;

@property (weak, nonatomic) IBOutlet UITableView *detailTableView;
@property (weak, nonatomic) IBOutlet MKMapView *detailMapView;

- (IBAction)segmentedValueChanged:(UISegmentedControl *)sender;

@end

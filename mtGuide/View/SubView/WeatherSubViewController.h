//
//  WeatherSubViewController.h
//  mtGuide
//
//  Created by Hisatomi Yasushi on 13/02/05.
//  Copyright (c) 2013年 hisatomiyasushi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class DetailViewController;

@interface WeatherSubViewController : UIViewController


@property (weak, nonatomic) IBOutlet UILabel *weatherLabel;
@property (weak, nonatomic) IBOutlet UIButton *dismissButton;

@property (nonatomic, copy) NSString *weatherSpotKeyNumber;

- (IBAction)dismissButtonDidTouch:(id)sender;



@end

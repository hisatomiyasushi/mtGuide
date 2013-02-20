//
//  StatsSubViewController.h
//  mtGuide
//
//  Created by Hisatomi Yasushi on 13/02/10.
//  Copyright (c) 2013年 hisatomiyasushi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@class DetailViewController;

@interface StatsSubViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *statsLabel;
@property (weak, nonatomic) IBOutlet UILabel *statsTitleLabel;
@property (nonatomic, copy) NSString *mtName;
@property (nonatomic, copy) NSString *mtYomi;
@property (nonatomic, copy) NSString *mtHeight;
@property (nonatomic, copy) NSString *mtRange;
@property (nonatomic, copy) NSString *mtPrefecture;
@property (weak, nonatomic) IBOutlet UIButton *dismissButton;

- (IBAction)dismissButtonDidTouch:(id)sender;

@end

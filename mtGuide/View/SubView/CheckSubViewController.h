//
//  CheckSubViewController.h
//  mtGuide
//
//  Created by Hisatomi Yasushi on 13/02/07.
//  Copyright (c) 2013年 hisatomiyasushi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class DetailViewController;


@interface CheckSubViewController : UIViewController
//@property (weak, nonatomic) IBOutlet UIButton *mapCheckButton;
@property (weak, nonatomic) IBOutlet UIButton *favCheckButton;
@property (weak, nonatomic) IBOutlet UIButton *hikeCheckButton;
//@property (weak, nonatomic) IBOutlet UIButton *shareButton;
//@property (weak, nonatomic) IBOutlet UIButton *itiButton;
@property (weak, nonatomic) IBOutlet UILabel *checkTitleLabel;
@property (nonatomic, copy) NSString *mtIdForKey;
//@property (weak, nonatomic) IBOutlet UIButton *dismissButton;

//- (IBAction)mcbDidTouch:(id)sender;
- (IBAction)fcbDidTouch:(id)sender;
- (IBAction)hcbDidTouch:(id)sender;
//- (IBAction)shbDidTouch:(id)sender;
//- (IBAction)itbDidTouch:(id)sender;
//- (IBAction)dismissButtonDidTouch:(id)sender;
@end

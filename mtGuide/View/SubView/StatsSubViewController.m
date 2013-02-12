//
//  StatsSubViewController.m
//  mtGuide
//
//  Created by Hisatomi Yasushi on 13/02/10.
//  Copyright (c) 2013年 hisatomiyasushi. All rights reserved.
//

#import "StatsSubViewController.h"
#import "UIViewController+KNSemiModal.h"
#import "DetailViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface StatsSubViewController ()

@end

@implementation StatsSubViewController
//
//- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
//{
//    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
//    if (self) {
//        // Custom initialization
//    }
//    return self;
//}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    _statsLabel.text = [NSString stringWithFormat:@"山名：%@ (%@)\n標高：%@m\n山系：%@\n都道府県：%@",_mtName,_mtYomi,_mtHeight,_mtRange,_mtPrefecture];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
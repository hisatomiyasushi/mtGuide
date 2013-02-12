//
//  MapViewController.m
//  mtGuide
//
//  Created by Hisatomi Yasushi on 13/01/09.
//  Copyright (c) 2013年 hisatomiyasushi. All rights reserved.
//

#import "MapViewController.h"

@interface MapViewController ()

@end

@implementation MapViewController

- (IBAction)segmentSwitch2:(id)sender {
    
    if([sender selectedSegmentIndex] == 0)
    {
        UIViewController *controller = [[self storyboard] instantiateViewControllerWithIdentifier:@"ViewController"];
        controller.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
        [self presentViewController:controller animated:YES completion: nil];
    }
    
    else if([sender selectedSegmentIndex] == 1)
    {
        UIViewController *controller = [[self storyboard] instantiateViewControllerWithIdentifier:@"MapViewController"];
        controller.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
        [self presentViewController:controller animated:YES completion: nil];
    }
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    segmentedcontrol.selectedSegmentIndex = 1;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

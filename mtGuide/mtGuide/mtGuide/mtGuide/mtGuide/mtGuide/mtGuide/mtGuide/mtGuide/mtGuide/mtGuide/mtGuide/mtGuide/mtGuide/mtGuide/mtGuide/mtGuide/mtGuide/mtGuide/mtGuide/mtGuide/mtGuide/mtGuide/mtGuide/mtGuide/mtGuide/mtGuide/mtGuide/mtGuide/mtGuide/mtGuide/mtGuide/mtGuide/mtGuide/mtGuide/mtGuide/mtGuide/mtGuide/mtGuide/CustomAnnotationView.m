//
//  CustomAnnotationView.m
//  FlickrApp
//
//  Created by Hisatomi Yasushi on 13/01/16.
//  Copyright (c) 2013年 hisatomiyasushi. All rights reserved.
//


#import "CustomAnnotationView.h"
#import "CustomAnnotation.h"

@implementation CustomAnnotationView
//@synthesize delegate;

- (id)initWithAnnotation:(id <MKAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier
//                delegate:(id<CustomAnnotationViewDelegate>) _delegate
{
    
//    [self setDelegate:_delegate];
    
    self = [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier];
    self.image = [UIImage imageNamed:@"flag.png"];
    
    self.canShowCallout = YES;
    
    UIButton* button = [UIButton buttonWithType:UIButtonTypeDetailDisclosure]; //……【1】
    [button addTarget:self action:@selector(showDetail:)
     forControlEvents:UIControlEventTouchUpInside]; //……【2】
    self.rightCalloutAccessoryView = button; //……【3】
    
    return self;
}

-(void) showDetail: (id) sender { //……【4】
    NSURL *url = [[NSURL alloc] initWithString: [(Photo*)self.annotation url] ];
    [[UIApplication sharedApplication] openURL:url];
//    [self.delegate openUrl: (Photo*)self.annotation];
}

@end

//
//  CustomAnnotationView.h
//  FlickrApp
//
//  Created by Hisatomi Yasushi on 13/01/16.
//  Copyright (c) 2013年 hisatomiyasushi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import "Photo.h"
//#import "CustomAnnotationViewDelegate.h"

@interface CustomAnnotationView : MKAnnotationView
//{
//    id<CustomAnnotationViewDelegate> delegate;
//}

//@property (nonatomic, retain) id<CustomAnnotationViewDelegate> delegate;

-(void) showDetail: (id) sender;

@end
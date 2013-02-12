//
//  CustomAnnotation.m
//  mtGuide
//
//  Created by Hisatomi Yasushi on 13/01/14.
//  Copyright (c) 2013年 hisatomiyasushi. All rights reserved.
//
#import "CustomAnnotation.h"

@implementation CustomAnnotation
@synthesize coordinate,
            annotationTitle,
            annotationSubtitle;

- (NSString *)title {
    return annotationTitle;
}

- (NSString *)subtitle {
    return annotationSubtitle;
}

- (id)initWithLocationCoordinate:(CLLocationCoordinate2D) _coordinate
                           title:(NSString *)_annotationTitle subtitle:(NSString *)_annotationSubtitle {
    coordinate = _coordinate;
    self.annotationTitle = _annotationTitle;
    self.annotationSubtitle = _annotationSubtitle;
        
    return self;
}







@end

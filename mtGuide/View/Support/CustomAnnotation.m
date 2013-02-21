//
//  CustomAnnotation.m
//  mtGuide
//
//  Created by Hisatomi Yasushi on 13/01/14.
//  Copyright (c) 2013年 hisatomiyasushi. All rights reserved.
//
#import "CustomAnnotation.h"

@implementation CustomAnnotation

- (id)initWithLocationCoordinate:(CLLocationCoordinate2D) coord
                           title:(NSString *)annTitle
                        subtitle:(NSString *)annSubtitle {
    _coordinate = coord;
    _annotationTitle = annTitle;
    _annotationSubtitle = annSubtitle;
        
    return self;
}

- (NSString *)title {
    return _annotationTitle;
}

- (NSString *)subtitle {
    return _annotationSubtitle;
}

@end

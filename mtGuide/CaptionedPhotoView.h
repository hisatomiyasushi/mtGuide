//
//  CaptionedPhotoView.h
//  mtGuide
//
//  Created by Hisatomi Yasushi on 13/01/31.
//  Copyright (c) 2013年 hisatomiyasushi. All rights reserved.
//


#import <UIKit/UIKit.h>

/**
 * A subclass of NIPhotoScrollView that shows a caption beneath the picture.
 *
 * This class is purposefully lightweight and simply presents the caption without providing
 * any means of configuring the caption. This is left as an exercise to the developer.
 */

@interface CaptionedPhotoView : NIPhotoScrollView

@property (nonatomic, readwrite, copy) NSString* caption;
@property (nonatomic, readwrite, retain) UIView* captionWell;

@end

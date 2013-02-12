//
//  CaptionedPhotoView.m
//  mtGuide
//
//  Created by Hisatomi Yasushi on 13/01/31.
//  Copyright (c) 2013年 hisatomiyasushi. All rights reserved.
//

#import "CaptionedPhotoView.h"

static UIEdgeInsets kWellPadding = {0}; // see +initialize

@interface CaptionedPhotoView ()

@property (nonatomic, readwrite, retain) UILabel* captionLabel;

@end

@implementation CaptionedPhotoView

///////////////////////////////////////////////////////////////////////////////////////////////////
+ (void)initialize {
    kWellPadding = UIEdgeInsetsMake(10, 10, 10, 10);
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (id)initWithFrame:(CGRect)frame {

    if ((self = [super initWithFrame:frame])) {
        _captionWell = [[UIView alloc] initWithFrame:self.bounds];
        _captionWell.autoresizingMask = (UIViewAutoresizingFlexibleWidth
                                         | UIViewAutoresizingFlexibleTopMargin);
        
        _captionLabel = [[UILabel alloc] initWithFrame:self.bounds];
        _captionLabel.backgroundColor = [UIColor clearColor];
        _captionLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        _captionLabel.numberOfLines = 0;
        _captionLabel.font = [UIFont systemFontOfSize:14];
        _captionLabel.textColor = [UIColor whiteColor];
        _captionLabel.shadowOffset = CGSizeMake(0, 1);
        _captionLabel.shadowColor = [UIColor colorWithWhite:0 alpha:0.5];
        
        UIView* topBorder = [[UIView alloc] initWithFrame:CGRectZero];
        topBorder.frame = CGRectMake(0, 0, self.bounds.size.width, 1);
        topBorder.autoresizingMask = (UIViewAutoresizingFlexibleBottomMargin
                                      | UIViewAutoresizingFlexibleWidth);
        
        _captionWell.backgroundColor = [UIColor colorWithWhite:0 alpha:0.7];
        topBorder.backgroundColor = [UIColor colorWithWhite:0.2 alpha:1];
        
        [_captionWell addSubview:topBorder];
        [_captionWell addSubview:_captionLabel];
        [self addSubview:_captionWell];

    }
    return self;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat availableWidth = self.bounds.size.width - kWellPadding.left - kWellPadding.right;
    
    CGSize labelSize =  [self.captionLabel.text sizeWithFont:self.captionLabel.font
                                           constrainedToSize:CGSizeMake(availableWidth, CGFLOAT_MAX)
                                               lineBreakMode:self.captionLabel.lineBreakMode];
    CGFloat wellHeight = labelSize.height + kWellPadding.top + kWellPadding.bottom;
//    self.captionWell.frame = CGRectMake(0, self.bounds.size.height - wellHeight - NIToolbarHeightForOrientation(NIInterfaceOrientation()),
    self.captionWell.frame = CGRectMake(0, self.bounds.size.height - NIToolbarHeightForOrientation(NIInterfaceOrientation()),
                                        self.bounds.size.width, wellHeight);
    self.captionLabel.frame = UIEdgeInsetsInsetRect(self.captionWell.bounds, kWellPadding);

}


///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - Public Methods


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setCaption:(NSString *)caption {
    if (_captionLabel.text != caption) {
        _captionLabel.text = caption;
        [self setNeedsLayout];
    }

}



///////////////////////////////////////////////////////////////////////////////////////////////////
- (NSString *)caption {
    return _captionLabel.text;
}

@end

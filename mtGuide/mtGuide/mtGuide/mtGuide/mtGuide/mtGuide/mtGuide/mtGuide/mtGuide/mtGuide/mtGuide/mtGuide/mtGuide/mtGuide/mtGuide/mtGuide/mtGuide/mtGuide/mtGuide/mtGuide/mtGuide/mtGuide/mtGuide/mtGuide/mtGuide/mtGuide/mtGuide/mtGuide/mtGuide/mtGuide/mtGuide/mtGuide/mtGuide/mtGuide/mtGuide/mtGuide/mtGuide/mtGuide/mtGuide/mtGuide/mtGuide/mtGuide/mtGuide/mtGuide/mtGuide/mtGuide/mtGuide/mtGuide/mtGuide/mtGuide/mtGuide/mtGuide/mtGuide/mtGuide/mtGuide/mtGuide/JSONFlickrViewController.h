//
//  JSONFlickrViewController.h
//  mtGuide
//
//  Created by Hisatomi Yasushi on 13/01/28.
//  Copyright (c) 2013年 hisatomiyasushi. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZoomedImageView;

@interface JSONFlickrViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate>
{
    UITextField     *searchTextField;
    UITableView     *theTableView;
    NSMutableArray  *photoTitles;         // Titles of images
    NSMutableArray  *photoSmallImageData; // Image data (thumbnail)
    NSMutableArray  *photoURLsLargeImage; // URL to larger image
    
    ZoomedImageView  *fullImageViewController;
    UIActivityIndicatorView *activityIndicator;
}

@end
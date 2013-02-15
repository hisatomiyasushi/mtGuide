//
//  InfoDetailViewController.h
//  mtGuide
//
//  Created by Hisatomi Yasushi on 13/01/13.
//  Copyright (c) 2013年 hisatomiyasushi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InfoDetailViewController : UIViewController

@property (nonatomic, retain) NSString *infodetailStr;
@property (nonatomic, retain) NSMutableArray *onsenList;

@property (nonatomic, retain) NSDictionary *mtItem;

@property(retain, nonatomic) NSArray *statuses;


@end

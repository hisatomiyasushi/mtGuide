//
//  InfoDetailViewController.h
//  mtGuide
//
//  Created by Hisatomi Yasushi on 13/01/13.
//  Copyright (c) 2013年 hisatomiyasushi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NimbusAttributedLabel.h"

@interface InfoDetailViewController : UIViewController<NSXMLParserDelegate, NIAttributedLabelDelegate>

@property (weak, nonatomic) IBOutlet UITextView *myTextView;
@property (nonatomic, retain) NSString *infodetailStr;
@property (nonatomic, retain) NSMutableArray *onsenList;
@property (nonatomic, retain) NSDictionary *mtItem;
@property(retain, nonatomic) NSArray *statuses;


@end

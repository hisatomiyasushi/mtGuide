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
//@property (nonatomic, retain) NSString *mtInformation;
//@property (nonatomic, retain) NSString *mtStr;
//@property (nonatomic, retain) NSString *onsenInformation;
@property (nonatomic, retain) NSMutableArray *onsenList;
//@property (strong, nonatomic) NSString *gaiyouStr;
//@property (strong, nonatomic) NSString *txtBuffer;
//@property (strong, nonatomic) NSString *txtBuffer02;
//@property (strong, nonatomic) NSString *nowTagStr;

@property (nonatomic, retain) NSDictionary *mtItem;



@end

//
//  InfoViewController.h
//  mtGuide
//
//  Created by Hisatomi Yasushi on 13/01/11.
//  Copyright (c) 2013年 hisatomiyasushi. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface InfoViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>

//@property (nonatomic, retain) NSString *mtStr;
@property (strong, nonatomic) id infoItem;
@property (nonatomic, retain) NSString *detailStr;
//@property (nonatomic, retain) NSArray *mttrails;
//@property (nonatomic, retain) NSArray *mtcamping;
//@property (nonatomic, retain) NSString *mtInformation;


@property (nonatomic, retain) NSDictionary *mtItem;


@end

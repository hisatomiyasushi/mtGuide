//
//  InfoViewController.h
//  mtGuide
//
//  Created by Hisatomi Yasushi on 13/01/11.
//  Copyright (c) 2013年 hisatomiyasushi. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface InfoViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>
{
    NSString *mtStr;
    NSString *detailStr;
    NSArray *infoData;
    NSArray *mtcamping;
    NSArray *detailData;
    NSString *mtInformation;

}
@property (nonatomic, retain) NSString *mtStr;

@property (strong, nonatomic) id infoItem;
@property (nonatomic, retain) NSString *detailStr;
@property (weak, nonatomic) IBOutlet UILabel *infoLabel;

@property (weak, nonatomic) IBOutlet UITableView *infoTableView;
@property (nonatomic, retain) NSArray *mttrails;
@property (nonatomic, retain) NSArray *mtcamping;
@property (nonatomic, retain) NSString *mtInformation;



@end

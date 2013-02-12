//
//  DetailCell.h
//  mtGuide
//
//  Created by Hisatomi Yasushi on 13/01/09.
//  Copyright (c) 2013年 hisatomiyasushi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *myLabel;
@property (weak, nonatomic) IBOutlet UILabel *mySubLabel;
@property (weak, nonatomic) IBOutlet UIImageView *myImageView;


@property (weak, nonatomic) IBOutlet UIImageView *detailCellImageView;
@property (weak, nonatomic) IBOutlet UILabel *detailCellLabel;


@property (weak, nonatomic) IBOutlet UILabel *infoCellLabel;
@property (weak, nonatomic) IBOutlet UIImageView *infoCellImageView;

@end

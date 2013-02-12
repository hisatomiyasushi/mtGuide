//
//  InfoDetailViewController.h
//  mtGuide
//
//  Created by Hisatomi Yasushi on 13/01/13.
//  Copyright (c) 2013年 hisatomiyasushi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InfoDetailViewController : UIViewController<NSXMLParserDelegate>
{
    NSString *mtStr;
    NSString *infodetailStr;
    NSString *mtInformation;
//    NSMutableString *currentElementValue;
}

@property (nonatomic, retain) NSString *infodetailStr;

@property (strong, nonatomic) NSString *gaiyouStr;
@property (strong, nonatomic) NSString *txtBuffer;
@property (strong, nonatomic) NSString *txtBuffer02;

@property (nonatomic, retain) NSString *mtInformation;
@property (nonatomic, retain) NSString *mtStr;


@property (weak, nonatomic) IBOutlet UITextView *myTextView;

@property (weak, nonatomic) IBOutlet UILabel *infodetailLabel;

@end

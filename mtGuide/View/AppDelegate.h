//
//  AppDelegate.h
//  mtGuide
//
//  Created by Hisatomi Yasushi on 13/01/09.
//  Copyright (c) 2013年 hisatomiyasushi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

//共有データの設定
@property (nonatomic, retain) NSArray *myregKeys;
@property (nonatomic, retain) NSArray *dataArray;
@property (nonatomic, retain) NSDictionary *mydataSource;

@end
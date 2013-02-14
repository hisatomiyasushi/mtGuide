//
//  CheckSubViewController.m
//  mtGuide
//
//  Created by Hisatomi Yasushi on 13/02/07.
//  Copyright (c) 2013年 hisatomiyasushi. All rights reserved.
//

#import "CheckSubViewController.h"
#import "UIViewController+KNSemiModal.h"
#import "DetailViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface CheckSubViewController ()

@end

@implementation CheckSubViewController
{
@private
    NSString *_fkeyStr;
    NSString *_hkeyStr;

}



//- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
//{
//    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
//    if (self) {
//        // Custom initialization
//    }
//    return self;
//}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    // NSUserDefaults インスタンスを準備
    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
    //データベースから値を取り出し
    _fkeyStr = [NSString stringWithFormat:@"KEY_FAV_%@",_mtIdForKey];
    _hkeyStr = [NSString stringWithFormat:@"KEY_HIKE_%@",_mtIdForKey];
    BOOL favboolValue = [defaults boolForKey:_fkeyStr];
    BOOL hikeboolValue = [defaults boolForKey:_hkeyStr];
    //ON・OFFを判定してボタン表示の出し分け
    if (favboolValue == YES) {
        // OFF時の通常画像設定
        [_favCheckButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        // OFF時のボタンをタップ中の画像設定
        [_favCheckButton setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
        // OFF時のボタン選択時の画像設定
        [_favCheckButton setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];

    }
    else
    {
        // OFF時の通常画像設定
        [_favCheckButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        // OFF時のボタンをタップ中の画像設定
        [_favCheckButton setTitleColor:[UIColor blueColor] forState:UIControlStateHighlighted];
        // OFF時のボタン選択時の画像設定
        [_favCheckButton setTitleColor:[UIColor blueColor] forState:UIControlStateSelected];

    }
    
    if (hikeboolValue == YES) {
        // OFF時の通常画像設定
        [_hikeCheckButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        // OFF時のボタンをタップ中の画像設定
        [_hikeCheckButton setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
        // OFF時のボタン選択時の画像設定
        [_hikeCheckButton setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
        
    }
    else
    {
        // OFF時の通常画像設定
        [_hikeCheckButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        // OFF時のボタンをタップ中の画像設定
        [_hikeCheckButton setTitleColor:[UIColor blueColor] forState:UIControlStateHighlighted];
        // OFF時のボタン選択時の画像設定
        [_hikeCheckButton setTitleColor:[UIColor blueColor] forState:UIControlStateSelected];
        
    }

    
}

- (void)viewDidUnload {
    [self setMapCheckButton:nil];
    [self setFavCheckButton:nil];
    [self setHikeCheckButton:nil];
    [self setShareButton:nil];
    [self setItiButton:nil];
    [super viewDidUnload];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)mcbDidTouch:(id)sender {
}

- (IBAction)fcbDidTouch:(id)sender {
    if (!_favCheckButton.selected) {
        // ON に変わった場合
        // OFFの画像設定
        [_favCheckButton setTitleColor:[UIColor blueColor] forState:UIControlStateHighlighted];
        // OFFの画像設定
        [_favCheckButton setTitleColor:[UIColor blueColor] forState:UIControlStateSelected];
        // OFFの画像設定
        [_favCheckButton setTitleColor:[UIColor blueColor] forState:UIControlStateHighlighted | UIControlStateSelected];

        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setBool:YES forKey:_fkeyStr];
        [defaults synchronize];
        NSLog(@"お気に入りONです");
    }
    else
    {
        // OFF に変わった場合
        // ONの画像設定
        [_favCheckButton setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
        // ONの画像設定
        [_favCheckButton setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
        // ONの画像設定
        [_favCheckButton setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted | UIControlStateSelected];
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setBool:NO forKey:_fkeyStr];
        [defaults synchronize];
        NSLog(@"お気に入りOFFです");
    }
    
    _favCheckButton.selected = !_favCheckButton.selected;

    if (!_favCheckButton.selected) {
        [_favCheckButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    } else {
        [_favCheckButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    }
    
}



- (IBAction)hcbDidTouch:(id)sender {
    if (!_hikeCheckButton.selected) {
        // ON に変わった場合
        // OFFの画像設定
        [_hikeCheckButton setTitleColor:[UIColor blueColor] forState:UIControlStateHighlighted];
        // OFFの画像設定
        [_hikeCheckButton setTitleColor:[UIColor blueColor] forState:UIControlStateSelected];
        // OFFの画像設定
        [_hikeCheckButton setTitleColor:[UIColor blueColor] forState:UIControlStateHighlighted | UIControlStateSelected];
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setBool:YES forKey:_hkeyStr];
        [defaults synchronize];
        NSLog(@"登頂ONです");
    }
    else
    {
        // OFF に変わった場合
        // ONの画像設定
        [_hikeCheckButton setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
        // ONの画像設定
        [_hikeCheckButton setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
        // ONの画像設定
        [_hikeCheckButton setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted | UIControlStateSelected];
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setBool:NO forKey:_hkeyStr];
        [defaults synchronize];
        NSLog(@"登頂OFFです");
    }
    
    _hikeCheckButton.selected = !_hikeCheckButton.selected;
    
    if (!_hikeCheckButton.selected) {
        [_hikeCheckButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    } else {
        [_hikeCheckButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    }
}

- (IBAction)shbDidTouch:(id)sender {
}

- (IBAction)itbDidTouch:(id)sender {
}
@end

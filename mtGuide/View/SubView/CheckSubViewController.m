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
    BOOL *favboolValue;
    BOOL *hikeboolValue;

}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.

    // 背景に画像をセットする
    UIImage *bgImage = [UIImage imageNamed:@"body-bg.png"];
    self.view.backgroundColor=[UIColor colorWithPatternImage: bgImage];

    // ボタンデザインの設定
    UIEdgeInsets insets;
    insets.top = insets.bottom = insets.left = insets.right = 5;

    [_favCheckButton setImage:[UIImage imageNamed:@"icon-heart.png"] forState:UIControlStateNormal];
    [_hikeCheckButton setImage:[UIImage imageNamed:@"icon-flag.png"] forState:UIControlStateNormal];

    _favCheckButton.layer.cornerRadius  = 10.0f;
    _favCheckButton.layer.masksToBounds = YES;

    _hikeCheckButton.layer.cornerRadius  = 10.0f;
    _hikeCheckButton.layer.masksToBounds = YES;
    
    _favCheckButton.titleLabel.numberOfLines = 0;
    _favCheckButton.titleEdgeInsets = insets;
    _favCheckButton.contentEdgeInsets = insets;
    
    _hikeCheckButton.titleLabel.numberOfLines = 0;
    _hikeCheckButton.titleEdgeInsets = insets;
    _hikeCheckButton.contentEdgeInsets = insets;

    // NSUserDefaults インスタンスを準備
    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
    // データベースから値を取り出し
    _fkeyStr = [NSString stringWithFormat:@"KEY_FAV_%@",_mtIdForKey];
    _hkeyStr = [NSString stringWithFormat:@"KEY_HIKE_%@",_mtIdForKey];
    favboolValue = [defaults boolForKey:_fkeyStr];
    hikeboolValue = [defaults boolForKey:_hkeyStr];
    
    // ON・OFFを判定してボタン表示の出し分け
    if (favboolValue) {
        [_favCheckButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [_favCheckButton setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
        [_favCheckButton setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
    }
    else {
        [_favCheckButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_favCheckButton setTitleColor:[UIColor blueColor] forState:UIControlStateHighlighted];
        [_favCheckButton setTitleColor:[UIColor blueColor] forState:UIControlStateSelected];
    }
    
    if (hikeboolValue) {
        [_hikeCheckButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [_hikeCheckButton setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
        [_hikeCheckButton setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
    }
    else {
        [_hikeCheckButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_hikeCheckButton setTitleColor:[UIColor blueColor] forState:UIControlStateHighlighted];
        [_hikeCheckButton setTitleColor:[UIColor blueColor] forState:UIControlStateSelected];
    }
}


- (IBAction)mcbDidTouch:(id)sender {
}


// お気に入りボタンタップ時の処理
- (IBAction)fcbDidTouch:(id)sender {
    //初期表示設定
    if (favboolValue) {
        _favCheckButton.selected = YES;
        favboolValue = !favboolValue;

    }
    else {
        _favCheckButton.selected = NO;
        favboolValue = !favboolValue;
    }
    
    //タップしてNSUserDefaultに保存
    if (!_favCheckButton.selected) {
        [_favCheckButton setTitleColor:[UIColor blueColor] forState:UIControlStateHighlighted];
        [_favCheckButton setTitleColor:[UIColor blueColor] forState:UIControlStateSelected];
        [_favCheckButton setTitleColor:[UIColor blueColor] forState:UIControlStateHighlighted | UIControlStateSelected];
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setBool:YES forKey:_fkeyStr];
        [defaults synchronize];
        NSLog(@"お気に入りONです");
    }
    else {
        [_favCheckButton setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
        [_favCheckButton setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
        [_favCheckButton setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted | UIControlStateSelected];

        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setBool:NO forKey:_fkeyStr];
        [defaults synchronize];
        NSLog(@"お気に入りOFFです");
    }

    //ON・OFF切り替え
    _favCheckButton.selected = !_favCheckButton.selected;
    
    //ボタン色切り替え
    if (!_favCheckButton.selected) {
        [_favCheckButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    } else {
        [_favCheckButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    }
}

// 登ったボタンタップ時の処理
- (IBAction)hcbDidTouch:(id)sender {
    //初期表示設定
    if (hikeboolValue) {
        _hikeCheckButton.selected = YES;
        hikeboolValue = !hikeboolValue;
        
    }
    else {
        _hikeCheckButton.selected = NO;
        hikeboolValue = !hikeboolValue;
    }
    
    //タップしてNSUserDefaultに保存
    if (!_hikeCheckButton.selected) {
        [_hikeCheckButton setTitleColor:[UIColor blueColor] forState:UIControlStateHighlighted];
        [_hikeCheckButton setTitleColor:[UIColor blueColor] forState:UIControlStateSelected];
        [_hikeCheckButton setTitleColor:[UIColor blueColor] forState:UIControlStateHighlighted | UIControlStateSelected];
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setBool:YES forKey:_hkeyStr];
        [defaults synchronize];
        NSLog(@"登頂ONです");
    }
    else {
        [_hikeCheckButton setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
        [_hikeCheckButton setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
        [_hikeCheckButton setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted | UIControlStateSelected];
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setBool:NO forKey:_hkeyStr];
        [defaults synchronize];
        NSLog(@"登頂OFFです");
    }
    
    //ON・OFF切り替え
    _hikeCheckButton.selected = !_hikeCheckButton.selected;
    
    //ボタン色切り替え
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


- (IBAction)dismissButtonDidTouch:(id)sender {
    // Here's how to call dismiss button on the parent ViewController
    // be careful with view hierarchy
    
    UIViewController *parent = [self.view containingViewController];
    if ([parent respondsToSelector:@selector(dismissSemiModalView)]) {
        [parent dismissSemiModalView];
    }
}


@end

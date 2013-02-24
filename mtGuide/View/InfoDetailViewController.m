//
//  InfoDetailViewController.m
//  mtGuide
//
//  Created by Hisatomi Yasushi on 13/01/13.
//  Copyright (c) 2013年 hisatomiyasushi. All rights reserved.
//

#import "InfoDetailViewController.h"
#import "InfoViewController.h"
#import "DetailViewController.h"
#import "URLLoader.h"
#import "StatusXMLParser.h"

@interface InfoDetailViewController ()
@end

@implementation InfoDetailViewController
{
    NSString *_wikiText_second;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


///////////////////////////////////////////////////////////////////////////////////////////////////

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.title = _infodetailStr;
//    self.myTextView.text = _infodetailStr;

    NSArray *mtTrails = [_mtItem objectForKey:@"trails"];
    NSArray *mtCamping = [_mtItem objectForKey:@"camping"];

        
    //テキストビューの初期化と編集不可に設定
    _myTextView.text = @"";
    _myTextView.editable = NO;
    
    // 背景に画像をセットする
    UIImage *bgImage = [UIImage imageNamed:@"body-bg.png"];
    self.view.backgroundColor=[UIColor colorWithPatternImage: bgImage];
    self.myTextView.backgroundColor=[UIColor colorWithPatternImage: bgImage];


    // 「温泉情報」かそれ以外の場合で、XMLパース処理の呼び出しをするorしない処理を開始
    if ([_infodetailStr isEqualToString:@"概要"]) {
        
        _myTextView.text = [_mtItem objectForKey:@"information"];

    }
    
    else if ([_infodetailStr isEqualToString:@"アクセス"]){
        
        _myTextView.text = [_mtItem objectForKey:@"access"];
        
    }

    else if ([_infodetailStr isEqualToString:@"登山適期"]){
        
        _myTextView.text = [_mtItem objectForKey:@"season"];
        
    }

    else if ([_infodetailStr isEqualToString:@"登山案内・管轄警察"]){
        
        _myTextView.text = [_mtItem objectForKey:@"contact"];
        
    }
    
    else if ([_infodetailStr isEqualToString:@"周辺の温泉"]) {

        //温泉XMLパース処理の呼び出し
        [self loadTimeLineByUserName:@"Onsen"];
    }
    
    else if ([_infodetailStr isEqualToString:@"登山ルート"]){
        for (int i = 0; i < [mtTrails count]; i++) {
            NSString *trailsText = [mtTrails objectAtIndex:i];
            _myTextView.text = [_myTextView.text stringByAppendingFormat:@"●%@\n",trailsText];
        }
        
    }
    else if ([_infodetailStr isEqualToString:@"キャンプ場・山小屋"]){
        for (int i = 0; i < [mtTrails count]; i++) {
            NSString *campingText = [mtCamping objectAtIndex:i];
            _myTextView.text = [_myTextView.text stringByAppendingFormat:@"●%@\n",campingText];
        }
    }

}
    


//XML読み込み/////////////////////////////////////////////////////////////////////////////////////////////////

- (void) loadTimeLineByUserName: (NSString *) userName {
    
    if ([userName isEqualToString:@"Wikipedia"]){

        NSString *mtInformation = [_mtItem objectForKey:@"information"];
        NSString *urlFormat = mtInformation;
        NSString *url = [NSString stringWithFormat:urlFormat, userName];
        URLLoader *loder = [[URLLoader alloc] init];
        
        [[NSNotificationCenter defaultCenter] addObserver: self
                                                 selector: @selector(loadTimeLineDidEnd:)
                                                     name: @"connectionDidFinishNotification"
                                                   object: loder];
        
        [[NSNotificationCenter defaultCenter] addObserver: self
                                                 selector: @selector(loadTimeLineFailed:)
                                                     name: @"connectionDidFailWithError"
                                                   object: loder];
        
        [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
        
        [loder loadFromUrl:url method: @"GET"];

    } else if ([userName isEqualToString:@"Onsen"]){
        
        NSString *mtHotsprings = [_mtItem objectForKey:@"hotsprings"];
        NSString *urlFormat = mtHotsprings;
        NSString *url = [NSString stringWithFormat:urlFormat, userName];
        URLLoader *loder = [[URLLoader alloc] init];

        [[NSNotificationCenter defaultCenter] addObserver: self
                                                 selector: @selector(loadTimeLineDidEnd:)
                                                     name: @"connectionDidFinishNotification"
                                                   object: loder];

        [[NSNotificationCenter defaultCenter] addObserver: self
                                                 selector: @selector(loadTimeLineFailed:)
                                                     name: @"connectionDidFailWithError"
                                                   object: loder];

        [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;

        [loder loadFromUrl:url method: @"GET"];
    }
    
}


- (void) loadTimeLineDidEnd: (NSNotification *)notification {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    URLLoader *loder = (URLLoader *)[notification object];
    NSData *xmlData = loder.data;
    
    StatusXMLParser *parser = [[StatusXMLParser alloc] init];
    self.statuses = [parser parseStatuses:xmlData];

    if ([_infodetailStr isEqualToString:@"周辺の温泉"]) {
        
        // 温泉情報の表示
        for (int i = 0; i < [_statuses count]; i++) {
            
            NSString *onsenName = [[_statuses objectAtIndex:i] objectForKey:@"OnsenName"];
            NSString *natureOfOnsen = [[_statuses objectAtIndex:i] objectForKey:@"NatureOfOnsen"];
            NSString *onsenAreaCaption = [[_statuses objectAtIndex:i] objectForKey:@"OnsenAreaCaption"];

            _myTextView.text = [_myTextView.text stringByAppendingFormat:@"\n温泉名：%@\n泉質：%@\n概要：%@\n",onsenName,natureOfOnsen,onsenAreaCaption];
        }
        
        
        //クレジット表示（リンク）設定
        NIAttributedLabel *_creditLabel = [[NIAttributedLabel alloc] initWithFrame:CGRectZero];
        
        _creditLabel.numberOfLines = 0;

        _creditLabel.text = @"じゃらん Web サービス";

        #if __IPHONE_OS_VERSION_MIN_REQUIRED < NIIOS_6_0
        _creditLabel.lineBreakMode = UILineBreakModeWordWrap;
        #else
        _creditLabel.lineBreakMode = NSLineBreakByWordWrapping;
        #endif
        
        [_creditLabel sizeToFit]; //ラベルサイズの自動調整
        [_creditLabel setBackgroundColor:[UIColor clearColor]]; //背景を透過
        _creditLabel.textAlignment = NSTextAlignmentRight; //文字を右寄せ
        _creditLabel.font = [UIFont systemFontOfSize:12]; //フォント設定

        _creditLabel.autoresizingMask = UIViewAutoresizingFlexibleDimensions;

        //ラベルを右上に寄せて表示
        CGRect newRect = _creditLabel.frame;
        newRect.origin.x = _myTextView.frame.size.width - _creditLabel.frame.size.width -10;
        newRect.origin.y = 5;
        _creditLabel.frame = newRect;
        
        // When the user taps a link we can change the way the link text looks.
        _creditLabel.attributesForHighlightedLink = [NSDictionary dictionaryWithObject:(id)RGBCOLOR(255, 0, 0).CGColor forKey:(NSString *)kCTForegroundColorAttributeName];
        
        // In order to handle the events generated by the user tapping a link we must implement the
        // delegate.
        _creditLabel.delegate = self;
        
        // By default the label will not automatically detect links. Turning this on will cause the label
        // to pass through the text with an NSDataDetector, highlighting any detected URLs.
        _creditLabel.autoDetectLinks = YES;
        
        // By default links do not have underlines and this is generally accepted as the standard on iOS.
        // If, however, you do wish to show underlines, you can enable them like so:
        _creditLabel.linksHaveUnderlines = YES;
        
        
        NSRange linkRange = [_creditLabel.text rangeOfString:@"じゃらん Web サービス"];
        
        // Explicitly adds a link at a given range.
        [_creditLabel addLink:[NSURL URLWithString:@"http://www.jalan.net/jw/jwp0000/jww0001.do"]
                        range:linkRange];
        
        [_myTextView addSubview:_creditLabel];
        

    }
}

- (void) loadTimeLineFailed: (NSNotification *)notification {
    
    UIAlertView *alert = [[UIAlertView alloc]
                          initWithTitle:@"エラー"
                          message:@"タイムラインの取得に失敗しました。"
                          delegate:self
                          cancelButtonTitle:@"閉じる"
                          otherButtonTitles:nil];
    [alert show];
}

//タップしたURL（じゃらんWEBサービス）にジャンプ
- (void)attributedLabel:(NIAttributedLabel*)attributedLabel didSelectTextCheckingResult:(NSTextCheckingResult *)result atPoint:(CGPoint)point {
    NIWebController* webController = [[NIWebController alloc] initWithURL:result.URL];
    webController.toolbarTintColor = [UIColor colorWithRed:0.04 green:0.15 blue:0.19 alpha:1];
    [self.navigationController pushViewController:webController
                                         animated:YES];
}


- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:@"connectionDidFinishNotification"
                                                  object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:@"connectionDidFailWithError"
                                                  object:nil];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:@"connectionDidFinishNotification"
                                                  object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:@"connectionDidFailWithError"
                                                  object:nil];
}
///////////////////////////////////////////////////////////////////////////////////////////////////


- (void)viewDidUnload {
    [super viewDidUnload]; // Release any retained subviews of the main view.
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

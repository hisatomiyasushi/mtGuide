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
<NSXMLParserDelegate>

@property (weak, nonatomic) IBOutlet UITextView *myTextView;
@property (weak, nonatomic) IBOutlet UILabel *infodetailLabel;

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
    self.infodetailLabel.text = _infodetailStr;

    //テキストビューの初期化と編集不可に設定
    _myTextView.text = @"";
    _myTextView.editable = NO;
    
    // 背景に画像をセットする
    UIImage *bgImage = [UIImage imageNamed:@"back.jpg"];
    self.view.backgroundColor=[UIColor colorWithPatternImage: bgImage];
    self.myTextView.backgroundColor=[UIColor colorWithPatternImage: bgImage];


    // 「概要」か「温泉情報」の場合、XMLパース処理の呼び出し処理を開始
    if ([_infodetailStr isEqualToString:@"概要"]) {
        self.infodetailLabel.text = _infodetailStr;
        
        //wikiXMLパース処理の呼び出し
        [self loadTimeLineByUserName:@"Wikipedia"];
    }
    
    else if ([_infodetailStr isEqualToString:@"周辺の温泉"]) {
        NSString *mtName = [_mtItem objectForKey:@"name"];
        self.infodetailLabel.text = [NSString stringWithFormat:@"%@周辺の温泉",mtName];
        //温泉XMLパース処理の呼び出し
        [self loadTimeLineByUserName:@"Onsen"];
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

    
//    // Wikipedia情報の表示
//    if ([_infodetailStr isEqualToString:@"概要"]) {
//        
//        NSString *wikiText = [[_statuses objectAtIndex:0] objectForKey:@"wikiText"];
//
//            //正規表現のオブジェクトを生成する
//            //options:0は、正規表現のmatch範囲をできるだけ狭くするように指定
//            NSError *error = nil;
//            
//            NSRegularExpression *regexp_first = [[NSRegularExpression alloc] initWithPattern:@"('{3})(.|[\r\n])*?(== )"
//                                                                                 options:0
//                                                                                   error:&error];//大雪山
//            if (error != nil) {
//                NSLog(@"正規表現エラーです。%@",error);
//            
//            } else {
//
//                //正規表現を対象xmlにかけてみる
//                //正規表現にマッチした件数分、結果が取得できる
//                NSArray *results_first = [regexp_first matchesInString:wikiText
//                                                       options:0
//                                                         range:NSMakeRange(0, [wikiText length])];
//                
//                
//                for ( int i = 0; i < results_first.count; i++){
//                    NSTextCheckingResult *result_first = [results_first objectAtIndex:i];
//                    _wikiText_second = [wikiText substringWithRange:[result_first rangeAtIndex:0]];
//                }
//            }
//            
//            //得られた抽出テキストから不要部分を削除するためにさらに正規表現置き換え処理
//            error = nil;
//            NSString *template = @""; //置換（＝削除）用文字列の設定
//            
//            NSRegularExpression *regexp_second = [[NSRegularExpression alloc] initWithPattern:@"(\'\'\'|==|概要|\\[|\\]|<ref.*?/>|<ref.*?ref>)"
//                                                                                 options:0
//                                                                                   error:&error];
//            if (error != nil) {
//                NSLog(@"正規表現エラーです。%@",error);
//            } else {
//                
//                NSString *replaced = [regexp_second stringByReplacingMatchesInString:_wikiText_second
//                                                                        options:0
//                                                                          range:NSMakeRange(0,_wikiText_second.length)
//                                                                   withTemplate:template];
//                
//                _myTextView.text = [_myTextView.text stringByAppendingFormat:@"%@",replaced];
//                
//            }
    
    if ([_infodetailStr isEqualToString:@"周辺の温泉"]) {
        
        // 温泉情報の表示
        for (int i = 0; i < [_statuses count]; i++) {
            
        NSString *OnsenName = [[_statuses objectAtIndex:i] objectForKey:@"OnsenName"];
        NSString *NatureOfOnsen = [[_statuses objectAtIndex:i] objectForKey:@"NatureOfOnsen"];
        NSString *OnsenAreaCaption = [[_statuses objectAtIndex:i] objectForKey:@"OnsenAreaCaption"];

        _myTextView.text = [_myTextView.text stringByAppendingFormat:@"温泉名：%@\n泉質：%@\n概要：%@\n\n",OnsenName,NatureOfOnsen,OnsenAreaCaption];
        }
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

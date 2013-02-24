//
//  DetailViewController.m
//  mtGuide
//
//  Created by Hisatomi Yasushi on 13/01/10.
//  Copyright (c) 2013年 hisatomiyasushi. All rights reserved.
//

#import "DetailCell.h"
#import "DetailViewController.h"
#import "InfoViewController.h"
#import "CustomAnnotation.h"
#import "InfoDetailViewController.h"
#import "JSONFlickrViewController.h"
#import "UIViewController+KNSemiModal.h"
#import "WeatherSubViewController.h"
#import "CheckSubViewController.h"
#import "StatsSubViewController.h"
#import "TileOverlayView.h"
#import "URLLoader.h"
#import "StatusXMLParser.h"
#import "HMSegmentedControl.h"


@interface DetailViewController ()
@end

@implementation DetailViewController
{
    WeatherSubViewController *semiVC;
    CheckSubViewController *semiCheckVC;
    StatsSubViewController *semiStatsVC;
    UILabel *twitterLabel;
    UITextView *twitterTextView;
    UILabel *twitterTimeLabel;
    UIScrollView *scrollView;
    MKMapView *detailMapView;
}

#pragma mark - Managing the detail item

//　-----------------------
//　文字データ・その他を読み込み、表示する
//　-----------------------
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //　-----------------------
    //　マップビューを設定する
    //　-----------------------
    
    // マップビューの初期化と表示設定
    detailMapView = [[MKMapView alloc] init];
    detailMapView.frame = 	CGRectMake(0,0,320,480);
    detailMapView.delegate = self;
    detailMapView.mapType = MKMapTypeHybrid;
    detailMapView.showsUserLocation = YES;
    [self.view addSubview:detailMapView];    
    
    // 国土地理院地図のオーバーレイ初期設定
    MKMapRect visibleRect = [detailMapView mapRectThatFits:_overlay.boundingMapRect];
    detailMapView.visibleMapRect = visibleRect;
    visibleRect.size.width /= 2;
    visibleRect.size.height /= 2;
    visibleRect.origin.x += visibleRect.size.width / 2;
    visibleRect.origin.y += visibleRect.size.height / 2;
    detailMapView.visibleMapRect = visibleRect;
    
    //詳細地図での緯度・経度の取り出しと全体地図にピン表示
    NSString *mtName = [_mtItem objectForKey:@"name"];
    NSString *mtYomi = [_mtItem objectForKey:@"yomi"];
    NSString *mtlatStr = [_mtItem objectForKey:@"mtlatitude"];
    NSString *mtlngStr = [_mtItem objectForKey:@"mtlongitude"];
    
    NSMutableArray *annotations=[[NSMutableArray alloc] init];
    CustomAnnotation *myAnnotation = [[CustomAnnotation alloc] init];
    CLLocationCoordinate2D coordinate;
    coordinate.latitude = [mtlatStr doubleValue];
    coordinate.longitude = [mtlngStr doubleValue];
    myAnnotation.coordinate = coordinate;
    myAnnotation.annotationTitle = mtName;
    myAnnotation.annotationSubtitle = mtYomi;
    [detailMapView addAnnotation:myAnnotation];
    [annotations addObject:myAnnotation];

    
    // 地図表示時の表示位置・縮尺を指定
    double minLat = 9999.0;
    double minLng = 9999.0;
    double maxLat = -9999.0;
    double maxLng = -9999.0;
    double lat, lng;
    
    for (id<MKAnnotation> annotation in detailMapView.annotations){
        lat = annotation.coordinate.latitude;
        lng = annotation.coordinate.longitude;
        
        //緯度の最大最小を求める
        if(minLat > lat)
            minLat = lat;
        if(lat > maxLat)
            maxLat = lat;
        
        //経度の最大最小を求める
        if(minLng > lng)
            minLng = lng;
        if(lng > maxLng)
            maxLng = lng;
    }
       
    
    CLLocationCoordinate2D co;
    co.latitude = (maxLat + minLat) / 2.0; // 緯度
    co.longitude = (maxLng + minLng) / 2.0; // 経度
    
    
    MKCoordinateRegion cr = detailMapView.region;
    cr.center = co;
    cr.span.latitudeDelta = maxLat - minLat + 0.1;
    cr.span.longitudeDelta = maxLng - minLng + 0.1;
    ;
    [detailMapView setRegion:cr];
    
    
    
    //　-----------------------
    //　スクロールビューを設定する
    //　-----------------------

    // ベースのビュー設定
    self.view.frame = CGRectMake(0.0, 0.0, self.view.frame.size.width, self.view.frame.size.height);
    UIImage *bgImage = [UIImage imageNamed:@"body-bg.png"];
    self.view.backgroundColor=[UIColor colorWithPatternImage: bgImage];
    
    // スクロールビューの初期化とコンテンツビューの設定
    scrollView = [[UIScrollView alloc]initWithFrame: self.view.frame];
    CGSize s = scrollView.frame.size;
    CGRect contentRect = CGRectMake(0, 0, s.width, 760);
    UIView *contentView = [[UIView alloc] initWithFrame:contentRect];
    
    
    // コンテンツビューにのるメインビジュアルの表示
    UIImageView *mainImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 240)];
    NSString *mtId = [_mtItem objectForKey:@"id"];
    NSString *mainVisualFileName = [NSString stringWithFormat:@"%@.png",mtId];
    mainImageView.backgroundColor=[UIColor colorWithPatternImage: bgImage];
    mainImageView.image = [UIImage imageNamed:mainVisualFileName];
    [contentView addSubview: mainImageView];
    
    // メインビジュアルにのるイントロテキストの表示
    NSString *mtIntro = [_mtItem objectForKey:@"introduction"];
    UILabel *detailDescriptionLabel = [[UILabel alloc]init];
    detailDescriptionLabel.text = mtIntro;
    detailDescriptionLabel.textAlignment = NSTextAlignmentCenter;
    detailDescriptionLabel.font = [UIFont systemFontOfSize:14.0];
    detailDescriptionLabel.textColor = [UIColor colorWithRed:0.19 green:0.09 blue:0.17 alpha:1];
    detailDescriptionLabel.Frame = CGRectMake(0, 180, 290, 40);
    detailDescriptionLabel.adjustsFontSizeToFitWidth = YES;
    UIImage *intorBgImage = [UIImage imageNamed:@"intro-bg.png"];
    detailDescriptionLabel.backgroundColor=[UIColor colorWithPatternImage: intorBgImage];
    [mainImageView addSubview:detailDescriptionLabel];
    
    // コンテンツビューにのるStatsボタン設定
    UIButton *stButton = [UIButton buttonWithType:UIButtonTypeCustom];
    stButton.frame = CGRectMake(0, 240, 60, 44);
    [stButton setTitle:@"Stats"forState:UIControlStateNormal];
    stButton.titleLabel.font = [UIFont fontWithName:@"STHeitiSC-Light" size:16.0f];
    [stButton setTitleColor: [UIColor colorWithRed:0.19 green:0.09 blue:0.17 alpha:1] forState:UIControlStateNormal];
    [stButton setTitleColor: [UIColor colorWithRed:0.80 green:0.37 blue:0.71 alpha:1] forState:UIControlStateHighlighted];
    UIImage *statsImage = [UIImage imageNamed:@"icon-stats-s.png"];
    [stButton setImage:statsImage forState:UIControlStateNormal];
    UIImage *statsHImage = [UIImage imageNamed:@"icon-stats-s-h.png"];
    [stButton setImage:statsHImage forState:UIControlStateHighlighted];
    [stButton addTarget:self action:@selector(stButton:)
       forControlEvents:UIControlEventTouchUpInside];
    [contentView addSubview: stButton];
    
    // コンテンツビューにのるWeatherボタン設定
    UIButton *weButton = [UIButton buttonWithType:UIButtonTypeCustom];
    weButton.frame = CGRectMake(60, 240, 100, 44);
    [weButton setTitle:@"Weather"forState:UIControlStateNormal];
    weButton.titleLabel.font = [UIFont fontWithName:@"STHeitiSC-Light" size:16.0f];
    [weButton setTitleColor: [UIColor colorWithRed:0.19 green:0.09 blue:0.17 alpha:1] forState:UIControlStateNormal];
    [weButton setTitleColor: [UIColor colorWithRed:0.80 green:0.37 blue:0.71 alpha:1] forState:UIControlStateHighlighted];
    UIImage *weatherImage = [UIImage imageNamed:@"icon-weather-s.png"];
    [weButton setImage:weatherImage forState:UIControlStateNormal];
    UIImage *weatherHImage = [UIImage imageNamed:@"icon-weather-s-h.png"];
    [weButton setImage:weatherHImage forState:UIControlStateHighlighted];
    [weButton addTarget:self action:@selector(weButton:)
       forControlEvents:UIControlEventTouchUpInside];
    [contentView addSubview: weButton];
    
    // コンテンツビューにのるPhotoボタン設定
    UIButton *mtButton = [UIButton buttonWithType:UIButtonTypeCustom];
    mtButton.frame = CGRectMake(160, 240, 80, 44);
    [mtButton setTitle:@"Photo"forState:UIControlStateNormal];
    mtButton.titleLabel.font = [UIFont fontWithName:@"STHeitiSC-Light" size:16.0f];
    [mtButton setTitleColor: [UIColor colorWithRed:0.19 green:0.09 blue:0.17 alpha:1] forState:UIControlStateNormal];
    [mtButton setTitleColor: [UIColor colorWithRed:0.80 green:0.37 blue:0.71 alpha:1] forState:UIControlStateHighlighted];
    UIImage *photoImage = [UIImage imageNamed:@"icon-photo.png"];
    [mtButton setImage:photoImage forState:UIControlStateNormal];
    UIImage *photoHImage = [UIImage imageNamed:@"icon-photo-h.png"];
    [mtButton setImage:photoHImage forState:UIControlStateHighlighted];
    [mtButton addTarget:self action:@selector(mtButton:)
       forControlEvents:UIControlEventTouchUpInside];
    [contentView addSubview: mtButton];
    
    // コンテンツビューにのるCheckボタン設定
    UIButton *ckButton = [UIButton buttonWithType:UIButtonTypeCustom];
    ckButton.frame = CGRectMake(240, 240, 80, 44);
    [ckButton setTitle:@"Check"forState:UIControlStateNormal];
    ckButton.titleLabel.font = [UIFont fontWithName:@"STHeitiSC-Light" size:16.0f];
    [ckButton setTitleColor: [UIColor colorWithRed:0.19 green:0.09 blue:0.17 alpha:1] forState:UIControlStateNormal];
    [ckButton setTitleColor: [UIColor colorWithRed:0.80 green:0.37 blue:0.71 alpha:1] forState:UIControlStateHighlighted];
    UIImage *checkImage = [UIImage imageNamed:@"icon-check-s.png"];
    [ckButton setImage:checkImage forState:UIControlStateNormal];
    UIImage *checkHImage = [UIImage imageNamed:@"icon-check-s-h.png"];
    [ckButton setImage:checkHImage forState:UIControlStateHighlighted];
    [ckButton addTarget:self action:@selector(ckButton:)
       forControlEvents:UIControlEventTouchUpInside];
    [contentView addSubview: ckButton];
    
    // コンテンツビューにのるテーブルビューの設置
    self.detailTableView.frame = CGRectMake(0, 290, 320, 200);
    self.detailTableView.dataSource = self;
    self.detailTableView.delegate = self;
    self.detailTableView.backgroundColor=[UIColor colorWithPatternImage: bgImage];
    [contentView addSubview: _detailTableView];
    

    // コンテンツビューにのるTwitterマークの表示
    UIImage *twImage = [UIImage imageNamed:@"tw.png"];
    UIImageView *tw = [[UIImageView alloc] initWithImage:twImage];
    tw.opaque = NO;
    tw.backgroundColor = [UIColor colorWithWhite:1.0f alpha:0.0f];
    [tw setFrame:CGRectMake(25, 500, 43, 31)];
    [contentView addSubview:tw];
    
    // コンテンツビューにのるTwitterアカウント名の表示
    twitterLabel = [[UILabel alloc]init];
    twitterLabel.textAlignment = NSTextAlignmentLeft;
    twitterLabel.font = [UIFont systemFontOfSize:16.0];
    twitterLabel.textColor = [UIColor colorWithRed:0.19 green:0.09 blue:0.17 alpha:1];
    twitterLabel.Frame = CGRectMake(80, 500, 240, 30);
    twitterLabel.adjustsFontSizeToFitWidth = YES;
    twitterLabel.backgroundColor=[UIColor colorWithPatternImage: bgImage];
    [contentView addSubview: twitterLabel];
 
    // コンテンツビューにのるTwitterつぶやき背景ビューの表示
    UIView *twitterTextViewBg = [[UIView alloc]init];
    twitterTextViewBg.Frame = CGRectMake(15, 530, 291, 138);
    UIImage *twBg = [UIImage imageNamed:@"bubble.png"];
    twitterTextViewBg.backgroundColor=[UIColor colorWithPatternImage: twBg];
    [contentView addSubview: twitterTextViewBg];
    
    
    // コンテンツビューにのるTwitterつぶやきの表示
    twitterTextView = [[UITextView alloc]init];
    twitterTextView.Frame = CGRectMake(15, 540, 291, 138);
    twitterTextView.opaque = NO;
    twitterTextView.backgroundColor = [UIColor colorWithWhite:1.0f alpha:0.0f];
    twitterTextView.textAlignment = NSTextAlignmentLeft;
    twitterTextView.font = [UIFont systemFontOfSize:12.0];
    twitterTextView.textColor = [UIColor colorWithRed:0.19 green:0.09 blue:0.17 alpha:1];
    // Twitterテキスト表示部分の初期化と編集不可に設定
    twitterTextView.text = @"";
    twitterTextView.editable = NO;
    [contentView addSubview: twitterTextView];
    
    // コンテンツビューにのるつぶやき時間の表示
    twitterTimeLabel = [[UILabel alloc]init];
    twitterTimeLabel.textAlignment = NSTextAlignmentRight;
    twitterTimeLabel.font = [UIFont systemFontOfSize:12.0];
    twitterTimeLabel.textColor = [UIColor grayColor];
    twitterTimeLabel.Frame = CGRectMake(230, 635, 65, 30);
    twitterTimeLabel.adjustsFontSizeToFitWidth = YES;
    twitterTimeLabel.opaque = NO;
    twitterTimeLabel.backgroundColor = [UIColor colorWithWhite:1.0f alpha:0.0f];
    [contentView addSubview: twitterTimeLabel];
    
    // コンテンツビューを配置
    [scrollView addSubview: contentView];
    
    
    
    // スクロールView上のコンテンツViewのサイズを指定します。
    scrollView.contentSize = contentView.frame.size;
    // 初期表示するコンテンツViewの場所を指定します。
    scrollView.contentOffset = CGPointMake(0, 0);
    scrollView.backgroundColor=[UIColor colorWithPatternImage: bgImage];
    scrollView.delegate = self;
    scrollView.userInteractionEnabled = YES;

    // スクロールビューを配置
    [self.view addSubview: scrollView];

    
    //Twitterタイムライン読み込み
    [self loadTimeLineByUserName:@"NorthernAlps"];
    
    // 上部segmentedcontrolボタンの初期設定
    HMSegmentedControl *segmentedControl = [[HMSegmentedControl alloc] initWithSectionTitles:@[@"Guide", @"Map"]];
    [segmentedControl setFrame:CGRectMake(0, 0, 320, 34)];
    [segmentedControl setSelectionIndicatorHeight:4.0f];
    [segmentedControl setBackgroundColor:[UIColor colorWithRed:0.04 green:0.15 blue:0.19 alpha:1]];
    [segmentedControl setTextColor:[UIColor whiteColor]];
    [segmentedControl setSelectionIndicatorColor:[UIColor whiteColor]];
    [segmentedControl setSelectionIndicatorStyle:HMSelectionIndicatorFillsSegment];
    [segmentedControl setSelectedSegmentIndex:0];
    [segmentedControl setSegmentEdgeInset:UIEdgeInsetsMake(0, 20, 0, 20)];
    [segmentedControl addTarget:self action:@selector(segmentedControlChangedValue:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:segmentedControl];
    
    // タイトルバー、その他テキスト表示部分の設定
    self.title = mtName;
    
    _detailData = [[NSArray alloc]initWithObjects:
                   @"山の基本情報",
                   @"登山ルート",
                   //@"自然・遊び",
                   @"周辺の温泉",
                   @"キャンプ場・山小屋", nil];
    
    //天気情報ビューの初期化
    UIStoryboard *storyboard = self.storyboard;
    semiVC = [storyboard instantiateViewControllerWithIdentifier:@"WeatherSubViewController"];
    
    //Checkビューの初期化
    semiCheckVC = [storyboard instantiateViewControllerWithIdentifier:@"CheckSubViewController"];
    
    //Statsビューの初期化
    semiStatsVC = [storyboard instantiateViewControllerWithIdentifier:@"StatsSubViewController"];

}


//　-----------------------
//　国土地理院地図オーバーレイの動作設定
//　-----------------------
- (MKOverlayView *)mapView:(MKMapView *)mapView viewForOverlay:(id <MKOverlay>)ovl
{
    TileOverlayView *view = [[TileOverlayView alloc] initWithOverlay:ovl];
    view.tileAlpha = 1.0; // e.g. 0.6 alpha for semi-transparent overlay
    return view;
}


//　-----------------------
//　テーブル表示設定
//　-----------------------
#pragma mark - Table View

//セクション数
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

//項目数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_detailData count]; 
}

//各セルの表示内容設定
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {        
    //さらに下層のInfoViewControllerに飛ばす予定のセルの表示内容設定
    if (indexPath.row == 0) {
        static NSString *CellIdentififer = @"detailCell";
        DetailCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentififer];
        cell.detailCellLabel.text = [_detailData objectAtIndex:indexPath.row];
        cell.detailCellImageView.image = [UIImage imageNamed:@"kingslime.gif"];
        
        return cell;
    }
    //下層のInfoDetailViewControllerにダイレクトで飛ばす予定のセルの表示内容設定
    else {
        static NSString *CellIdentififer = @"detailCell2";
        DetailCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentififer];
        cell.detailCellLabel.text = [_detailData objectAtIndex:indexPath.row];
        cell.detailCellImageView.image = [UIImage imageNamed:@"slimeknight.gif"];
        
        return cell;
    }
}


// セルをタップした後に選択状態をすぐ解除する
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES]; // 選択状態の解除
}

//　-----------------------
//　上部segmentedcontrolボタンの動作設定
//　-----------------------
- (void)segmentedControlChangedValue:(UISegmentedControl *)sender {
    switch (sender.selectedSegmentIndex) {
        case 0:
            detailMapView.hidden = YES;
            scrollView.hidden = NO;
            break;
        case 1:
            detailMapView.hidden = NO;
            scrollView.hidden = YES;
            
            // apple地図に国土地理院地図をオーバーレイ
            _overlay = [[TileOverlay alloc] initOverlay];
            [detailMapView addOverlay:_overlay];

            break;
            
        default:
            break;
    }
}


//　-----------------------
//　サブビュー表示ボタンがタップされたときの処理
//　-----------------------

// Photoボタンがタップされたとき
- (void)mtButton:(id)sender {
    [self performSegueWithIdentifier:@"photoSegue" sender:self];    
}

// Weatherボタンがタップされたとき
- (void)weButton:(id)sender {
    
    NSString *mtweather = [_mtItem objectForKey:@"weather"];
    [semiVC setWeatherSpotKeyNumber: mtweather];
    NSString *mtName = [_mtItem objectForKey:@"name"];
    [semiVC setMtName: mtName];
    [self presentSemiViewController:semiVC withOptions:@{
     KNSemiModalOptionKeys.pushParentBack       : @(YES),
     KNSemiModalOptionKeys.animationDuration    : @(0.3),
     KNSemiModalOptionKeys.shadowOpacity        : @(0.3),
	 }];
    
}

// Checkボタンがタップされたとき
- (void)ckButton:(id)sender {
    
    NSString *mtId = [_mtItem objectForKey:@"id"];
    [semiCheckVC setMtIdForKey: mtId];
    [self presentSemiViewController:semiCheckVC withOptions:@{
     KNSemiModalOptionKeys.pushParentBack       : @(YES),
     KNSemiModalOptionKeys.animationDuration    : @(0.3),
     KNSemiModalOptionKeys.shadowOpacity        : @(0.3),
	 }];
}

// Statsボタンがタップされたとき
- (void)stButton:(id)sender {
    NSString *mtName = [_mtItem objectForKey:@"name"];
    NSString *mtYomi = [_mtItem objectForKey:@"yomi"];
    NSString *mtHeight = [_mtItem objectForKey:@"height"];
    NSString *mtRange = [_mtItem objectForKey:@"mtrange"];
    NSString *mtPrefecture = [_mtItem objectForKey:@"prefecture"];
    [semiStatsVC setMtName: mtName];
    [semiStatsVC setMtYomi: mtYomi];
    [semiStatsVC setMtHeight: mtHeight];
    [semiStatsVC setMtRange: mtRange];
    [semiStatsVC setMtPrefecture: mtPrefecture];
    
    [self presentSemiViewController:semiStatsVC withOptions:@{
     KNSemiModalOptionKeys.pushParentBack       : @(YES),
     KNSemiModalOptionKeys.animationDuration    : @(0.3),
     KNSemiModalOptionKeys.shadowOpacity        : @(0.3),
	 }];
}


//　-----------------------
//　Twitterタイムライン解析処理
//　-----------------------

// URL設定、読み込み完了・エラー通知
- (void) loadTimeLineByUserName: (NSString *) userName {
    static NSString *urlFormat = @"http://twitter.com/status/user_timeline/NorthernAlps";
    
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

// 読み込み解析完了、表示処理
- (void) loadTimeLineDidEnd: (NSNotification *)notification {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    URLLoader *loder = (URLLoader *)[notification object];
    NSData *xmlData = loder.data;
    

    StatusXMLParser *parser = [[StatusXMLParser alloc] init];
    self.statuses = [parser parseStatuses:xmlData];
    
    
    // TwitterAPIの時間情報を分かりやすい表示に変換
    NSString *dateStr = [[_statuses objectAtIndex:0] objectForKey:@"time"];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"EEE MMM dd HH:mm:ssz yyyy"];
    NSDate *date = [dateFormat dateFromString:dateStr];
    
    // Convert date object to desired output format
    [dateFormat setDateFormat:@"MM月dd日"];
    
    dateStr = [dateFormat stringFromDate:date];
    
    NSString *name = [[_statuses objectAtIndex:0] objectForKey:@"name"];
    NSString *text = [[_statuses objectAtIndex:0] objectForKey:@"text"];
    
    // アカウント名
    twitterLabel.text = name;
    
    // テキスト
    twitterTextView.text = text;

    //日時
    twitterTimeLabel.text = dateStr;

    
}

// 読み込み解析エラー表示処理
- (void) loadTimeLineFailed: (NSNotification *)notification {
    
    UIAlertView *alert = [[UIAlertView alloc]
                          initWithTitle:@"エラー"
                          message:@"タイムラインの取得に失敗しました。"
                          delegate:self
                          cancelButtonTitle:@"閉じる"
                          otherButtonTitles:nil];
    [alert show];
}


// 通知の解除
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





//　-----------------------
//　画面遷移時に遷移先のビューで必要な対応する値をセットする
//　-----------------------
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"infoSegue"]) {
        InfoViewController *viewController = [segue destinationViewController];
        NSInteger selectedIndex = [[self.detailTableView indexPathForSelectedRow] row];
        viewController.detailStr = [_detailData objectAtIndex:selectedIndex];
        viewController.mtItem = _mtItem;
    }
    if ([[segue identifier] isEqualToString:@"directinfodetailSegue"]) {
        InfoDetailViewController *viewController = [segue destinationViewController];
        NSInteger selectedIndex = [[self.detailTableView indexPathForSelectedRow] row];
        viewController.mtItem = _mtItem;
        viewController.infodetailStr = [_detailData objectAtIndex:selectedIndex];
    }
    if ([[segue identifier] isEqualToString:@"photoSegue"]) {
        JSONFlickrViewController *viewController = [segue destinationViewController];
        viewController.mtItem = _mtItem;
    }

}

//　-----------------------
//　メモリ管理
//　-----------------------
- (void)viewDidUnload {
    [super viewDidUnload]; // Release any retained subviews of the main view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end

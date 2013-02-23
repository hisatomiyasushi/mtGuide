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
}

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem
{
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        
        // Update the view.
        [self configureView];
    }
}

- (void)configureView
{
    // Update the user interface for the detail item.
    
    if (self.detailItem) {
        self.detailDescriptionLabel.text = [self.detailItem description];
    }
}


//　-----------------------
//　文字データ・その他を読み込み、表示する
//　-----------------------
- (void)viewDidLoad
{
    [super viewDidLoad];
    [_detailMapView setDelegate:self];
    [self configureView];
    
    //画面縦幅（スクロールビュー）の設定
    self.view.frame = CGRectMake(0.0, 0.0, self.view.frame.size.width, self.view.frame.size.height);
    self.scrollView.contentSize = CGSizeMake(self.view.frame.size.width, 800.0);
    _scrollView.delegate = self;
    [self.view addSubview: _scrollView];
    
    // 背景に画像をセットする
    UIImage *bgImage = [UIImage imageNamed:@"body-bg.png"];
    self.view.backgroundColor=[UIColor colorWithPatternImage: bgImage];
    self.scrollView.backgroundColor=[UIColor colorWithPatternImage: bgImage];
    self.detailTableView.backgroundColor=[UIColor colorWithPatternImage: bgImage];
    self.twitterTextView.backgroundColor=[UIColor colorWithPatternImage: bgImage];
    
    //Twitterテキスト表示部分の初期化と編集不可に設定
    _twitterTextView.text = @"";
    _twitterTextView.editable = NO;

    //Twitterタイムライン読み込み
    [self loadTimeLineByUserName:@"NorthernAlps"];

    // 上部segmentedcontrolボタンの初期設定
    HMSegmentedControl *segmentedControl = [[HMSegmentedControl alloc] initWithSectionTitles:@[@"Guide", @"Map"]];
    [segmentedControl setFrame:CGRectMake(0, 0, 320, 34)];
    [segmentedControl setSelectionIndicatorHeight:4.0f];
    [segmentedControl setBackgroundColor:[UIColor colorWithRed:0.1 green:0.4 blue:0.8 alpha:1]];
    [segmentedControl setTextColor:[UIColor whiteColor]];
    [segmentedControl setSelectionIndicatorColor:[UIColor colorWithRed:0.5 green:0.8 blue:1 alpha:1]];
    [segmentedControl setSelectionIndicatorStyle:HMSelectionIndicatorFillsSegment];
    [segmentedControl setSelectedSegmentIndex:0];
    [segmentedControl setSegmentEdgeInset:UIEdgeInsetsMake(0, 20, 0, 20)];
    [segmentedControl addTarget:self action:@selector(segmentedControlChangedValue:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:segmentedControl];

    // タイトルバー、その他テキスト表示部分の設定
    NSString *mtName = [_mtItem objectForKey:@"name"];
    NSString *mtIntro = [_mtItem objectForKey:@"introduction"];
    self.title = mtName;
    self.detailDescriptionLabel.text = mtIntro;
    self.detailTableView.dataSource = self;
    self.detailTableView.delegate = self;
    
    _detailData = [[NSArray alloc]initWithObjects:
                  @"山の基本情報",
                  @"登山ルート",
                //@"自然・遊び",
                  @"周辺の温泉",
                  @"キャンプ場・山小屋", nil];
    
    // 国土地理院地図のオーバーレイ初期設定
    MKMapRect visibleRect = [_detailMapView mapRectThatFits:_overlay.boundingMapRect];
    _detailMapView.visibleMapRect = visibleRect;
    visibleRect.size.width /= 2;
    visibleRect.size.height /= 2;
    visibleRect.origin.x += visibleRect.size.width / 2;
    visibleRect.origin.y += visibleRect.size.height / 2;
    _detailMapView.visibleMapRect = visibleRect;
    
    //詳細地図での緯度・経度の取り出しと全体地図にピン表示
    NSString *mtlatStr = [_mtItem objectForKey:@"mtlatitude"];
    NSString *mtlngStr = [_mtItem objectForKey:@"mtlongitude"];
    NSString *mtYomi = [_mtItem objectForKey:@"yomi"];
    
    NSMutableArray *annotations=[[NSMutableArray alloc] init];
    CustomAnnotation *myAnnotation = [[CustomAnnotation alloc] init];
    CLLocationCoordinate2D coordinate;
    coordinate.latitude = [mtlatStr doubleValue];
    coordinate.longitude = [mtlngStr doubleValue];
    myAnnotation.coordinate = coordinate;
    myAnnotation.annotationTitle = mtName;
    myAnnotation.annotationSubtitle = mtYomi;
    [_detailMapView addAnnotation:myAnnotation];
    [annotations addObject:myAnnotation];

    
    // 地図表示時の表示位置・縮尺を指定
    double minLat = 9999.0;
    double minLng = 9999.0;
    double maxLat = -9999.0;
    double maxLng = -9999.0;
    double lat, lng;
    
    for (id<MKAnnotation> annotation in _detailMapView.annotations){
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
    
    
    MKCoordinateRegion cr = _detailMapView.region;
    cr.center = co;
    cr.span.latitudeDelta = maxLat - minLat + 0.1;
    cr.span.longitudeDelta = maxLng - minLng + 0.1;
    ;
    [_detailMapView setRegion:cr];

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
            self.detailMapView.hidden = YES;
            self.scrollView.hidden = NO;
            break;
        case 1:
            self.detailMapView.hidden = NO;
            self.scrollView.hidden = YES;
            
            // apple地図に国土地理院地図をオーバーレイ
            _overlay = [[TileOverlay alloc] initOverlay];
            [_detailMapView addOverlay:_overlay];

            break;
            
        default:
            break;
    }
}


//　-----------------------
//　サブビュー表示ボタンがタップされたときの処理
//　-----------------------

// Photoボタンがタップされたとき
- (IBAction)mtButton:(id)sender {
}

// Weatherボタンがタップされたとき
- (IBAction)weButton:(id)sender {
    
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
- (IBAction)ckButton:(id)sender {
    
    NSString *mtId = [_mtItem objectForKey:@"id"];
    [semiCheckVC setMtIdForKey: mtId];
    [self presentSemiViewController:semiCheckVC withOptions:@{
     KNSemiModalOptionKeys.pushParentBack       : @(YES),
     KNSemiModalOptionKeys.animationDuration    : @(0.3),
     KNSemiModalOptionKeys.shadowOpacity        : @(0.3),
	 }];
}

// Statsボタンがタップされたとき
- (IBAction)stButton:(id)sender {
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
    
    NSString *name = [[_statuses objectAtIndex:0] objectForKey:@"name"];
    NSString *text = [[_statuses objectAtIndex:0] objectForKey:@"text"];
    
    // ユーザー名
    self.twitterLabel.text = name;
    
    // テキスト
    self.twitterTextView.text = text;

    
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

//
//  ViewController.m
//  mtGuide
//
//  Created by Hisatomi Yasushi on 13/01/09.
//  Copyright (c) 2013年 hisatomiyasushi. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"
#import "SharedData.h"
#import "DetailCell.h"
#import "DetailViewController.h"
#import "CustomAnnotation.h"
#import "HMSegmentedControl.h"

@interface ViewController ()
@end

@implementation ViewController
{
    NSArray *_myregKeys;
    NSArray *_dataArray;
    NSDictionary *_mydataSource;
    NSString *_tappedAnnotation;
@private
    NSString *_fkeyStr;
}


- (void)viewDidLoad {
    [super viewDidLoad];

    //　-----------------------
    //　山データの取り出しとページ整形
    //　-----------------------

    // SharedData内のデータをAppDelegateを介して取得
    // クラス呼び出し
    SharedData *cc = [[SharedData alloc] init];
    // メソッド呼び出し
    [cc SetMountainsMethod];
    // デリゲート呼び出し
    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    // 地域名リストを代入
    _myregKeys = appDelegate.myregKeys;
    // 個々の山の配列代入
    _dataArray = appDelegate.dataArray;
    // 地域別の山配列辞書代入
    _mydataSource = appDelegate.mydataSource;


    // ページタイトル設定
    self.title = @"日本百名山";
    
    [_myMapView setDelegate:self];
    self.myTableView.dataSource = self;
    self.myTableView.delegate = self;
    
    // 背景に画像をセットする
    UIImage *bgImage = [UIImage imageNamed:@"back.jpg"];
    self.view.backgroundColor=[UIColor colorWithPatternImage: bgImage];
    self.myTableView.backgroundColor=[UIColor colorWithPatternImage: bgImage];
    self.myMapView.backgroundColor=[UIColor colorWithPatternImage: bgImage];

    
    // 上部segmentedcontrolボタンの初期設定
    HMSegmentedControl *segmentedControl = [[HMSegmentedControl alloc] initWithSectionTitles:@[@"List", @"Map"]];
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
    
    // MapView上のボタン設置
    _mapSegCtl = [[HMSegmentedControl alloc] initWithSectionTitles:@[@"All", @"Favorite", @"Visit"]];
    [_mapSegCtl setSelectionIndicatorHeight:4.0f];
    [_mapSegCtl setBackgroundColor:[UIColor colorWithRed:0.1 green:0.4 blue:0.8 alpha:1]];
    [_mapSegCtl setTextColor:[UIColor whiteColor]];
    [_mapSegCtl setSelectionIndicatorColor:[UIColor colorWithRed:0.5 green:0.8 blue:1 alpha:1]];
    [_mapSegCtl setSelectionIndicatorStyle:HMSelectionIndicatorFillsSegment];
    [_mapSegCtl setSelectedSegmentIndex:0];
    [_mapSegCtl setSegmentEdgeInset:UIEdgeInsetsMake(0, 20, 0, 20)];
    [_mapSegCtl setCenter:CGPointMake(_myMapView.bounds.size.width / 2, _myMapView.bounds.size.height - 60)];
    [_mapSegCtl addTarget: self
                   action: @selector(segmentDidChange:)
         forControlEvents:UIControlEventValueChanged];
    [self.myMapView addSubview:_mapSegCtl];

}


//　-----------------------
//　addAnotation時のコールアウトボタン追加処理
//　-----------------------

- (void)mapView:(MKMapView*)mapView didAddAnnotationViews:(NSArray*)views {
    // アノテーションビューを取得する
    for (MKAnnotationView* annotationView in views) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
        // コールアウトの右側のアクセサリビューにボタンを追加する
        annotationView.rightCalloutAccessoryView = button;
    }
}


#pragma mark - Table View

//　-----------------------
//　テーブル内容の設定
//　-----------------------

//セクション数（地域数）の設定
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [_myregKeys count];
}

//セクション名（地域名）の設定
-(NSString *)tableView:(UITableView *)tableView
titleForHeaderInSection:(NSInteger)section {
    return [_myregKeys objectAtIndex:section];
}

//各セクションの項目数の設定
-(NSInteger)tableView:(UITableView *)tableView
numberOfRowsInSection:(NSInteger)section {
    id key = [_myregKeys objectAtIndex:section];
    return [[_mydataSource objectForKey:key] count];
}

//セクションの表示カスタマイズのはず
//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
//    UIView *v = [[UIView alloc] init];  [v setBackgroundColor:[UIColor blackColor]];
//    v.backgroundColor = [UIColor blackColor];
//    UILabel *lbl = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 320.0f, 22.0f)];
//    lbl.backgroundColor = [UIColor grayColor];
//    lbl.textColor = [UIColor whiteColor];
//    lbl.text = [NSString stringWithFormat:[TYPE_ARRAY objectAtIndex:section]];
//    [v addSubview:lbl];
//    return v;
//}

//各セルの表示内容の設定
-(UITableViewCell *)tableView:(UITableView *)tableView
        cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentififer = @"Cell";
    DetailCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentififer];
    if (!cell) {
       cell = [[DetailCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentififer];
    }

    //まずは、section番目のセクション名を抽出する
    id key = [_myregKeys objectAtIndex:indexPath.section];
    
    //セクション名のセクションにあるrow番目のデータを取り出す
    NSString *text = [[[_mydataSource objectForKey:key] objectAtIndex:indexPath.row] objectForKey:@"name"];
    NSString *subtext = [[[_mydataSource objectForKey:key] objectAtIndex:indexPath.row] objectForKey:@"yomi"];
    NSString *thumbtext = [NSString stringWithFormat:@"%@_thumb.jpg",[[[_mydataSource objectForKey:key] objectAtIndex:indexPath.row] objectForKey:@"id"]];
    cell.myLabel.text = text;
    cell.mySubLabel.text = subtext;
    cell.myImageView.image = [UIImage imageNamed: thumbtext];
    
    return cell;
}

// セルをタップした後に選択状態をすぐ解除する
- (void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


//　-----------------------
//　上部segmentedcontrolボタンの動作設定
//　-----------------------

- (void)segmentedControlChangedValue:(UISegmentedControl *)sender {

    // タップされたセルによって分岐させる
    switch (sender.selectedSegmentIndex) {
        
        // リスト表示ボタンタップ時
        case 0:
            self.myMapView.hidden = YES; // マップ非表示
            self.myTableView.hidden = NO; // リスト表示
            break;
            
        // マップ表示ボタンタップ時
        case 1:{
            self.myMapView.hidden = NO; // マップ表示
            self.myTableView.hidden = YES; // リスト非表示

            //緯度・経度の取り出しと全体地図にピン表示
            for(int i = 0; i < [_dataArray count]; i++){                
                NSMutableArray *annotations = [[NSMutableArray alloc] init];
                CustomAnnotation *myAnnotation = [[CustomAnnotation alloc] init];
                CLLocationCoordinate2D coordinate;
                coordinate.latitude = [[[_dataArray objectAtIndex:i] objectForKey:@"mtlatitude"] doubleValue];
                coordinate.longitude = [[[_dataArray objectAtIndex:i] objectForKey:@"mtlongitude"] doubleValue];
                myAnnotation.coordinate = coordinate;
                myAnnotation.annotationTitle = [[_dataArray objectAtIndex:i] objectForKey:@"name"];
                myAnnotation.annotationSubtitle = [[_dataArray objectAtIndex:i] objectForKey:@"yomi"];
                [_myMapView addAnnotation:myAnnotation];
                [annotations addObject:myAnnotation];
            }
    
            // 地図表示時の表示位置・縮尺を指定
            double minLat = 9999.0;
            double minLng = 9999.0;
            double maxLat = -9999.0;
            double maxLng = -9999.0;
            double lat, lng;

            _myMapView.showsUserLocation = NO;

            for (id<MKAnnotation> annotation in _myMapView.annotations){
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
            co.latitude = (maxLat + minLat) / 2.0;
            co.longitude = (maxLng + minLng) / 2.0;

            MKCoordinateRegion cr = _myMapView.region;
            cr.center = co;
            cr.span.latitudeDelta = maxLat - minLat + 1.0;
            cr.span.longitudeDelta = maxLng - minLng + 1.0;
            
            [_myMapView setRegion:cr];
        }
        break;

    default:
        break;
    }
}

//　-----------------------
//　Map下部segmentedcontrolボタンをタップしたときのアクション
//　-----------------------

- (void) segmentDidChange:(id)sender {
// タップされたセルによって分岐させる
    switch (_mapSegCtl.selectedSegmentIndex) {
            
    //　-----------------------
    //　Allボタンタップ時
    //　-----------------------
        case 0: {
            //緯度・経度の取り出しと全体地図にピン表示
            [_myMapView removeAnnotations: _myMapView.annotations];
            
            for(int i = 0; i < [_dataArray count]; i++){
                NSMutableArray *annotations = [[NSMutableArray alloc] init];
                CustomAnnotation *myAnnotation = [[CustomAnnotation alloc] init];
                CLLocationCoordinate2D coordinate;
                coordinate.latitude = [[[_dataArray objectAtIndex:i] objectForKey:@"mtlatitude"] doubleValue];
                coordinate.longitude = [[[_dataArray objectAtIndex:i] objectForKey:@"mtlongitude"] doubleValue];
                myAnnotation.coordinate = coordinate;
                myAnnotation.annotationTitle = [[_dataArray objectAtIndex:i] objectForKey:@"name"];
                myAnnotation.annotationSubtitle = [[_dataArray objectAtIndex:i] objectForKey:@"yomi"];
                [_myMapView addAnnotation:myAnnotation];
                [annotations addObject:myAnnotation];
            }

        }
            break;
            
    //　-----------------------
    //　Favorite表示ボタンタップ時
    //　-----------------------
        case 1: {
            // NSUserDefaultsからすべてのデータを取り出す
            NSDictionary *dic = [[NSUserDefaults standardUserDefaults] dictionaryRepresentation];
            // お気に入り登録した山を格納する配列を生成
            NSMutableArray *favArray = [[NSMutableArray alloc] init];
            
            // データベースからFAVかつYESの要素だけを抽出し、配列に登録
            for (id key in dic) {
                NSMutableString *keyName = [NSMutableString stringWithString:key];
                if ([key rangeOfString:@"KEY_FAV_"].location != NSNotFound && [[dic objectForKey:key] boolValue] == 1 ) {
                    [keyName deleteCharactersInRange: NSMakeRange(0, 8)];
                    [favArray addObject:keyName];
                }
            }
            
            //お気に入り登録した山の配列から各要素を取り出し、緯度・経度の取り出しと全体地図にピン表示
            [_myMapView removeAnnotations: _myMapView.annotations];
            
            for(int i = 0; i < [favArray count]; i++){
                NSMutableArray *favAnnotations = [[NSMutableArray alloc] init];
                CustomAnnotation *myFavAnnotation = [[CustomAnnotation alloc] init];
                CLLocationCoordinate2D coordinate;
                coordinate.latitude = [[[_dataArray objectAtIndex:[[_dataArray valueForKeyPath:@"id"] indexOfObject:[favArray objectAtIndex:i]]]
                                        objectForKey:@"mtlatitude"] doubleValue];
                coordinate.longitude = [[[_dataArray objectAtIndex:[[_dataArray valueForKeyPath:@"id"] indexOfObject:[favArray objectAtIndex:i]]]
                                         objectForKey:@"mtlongitude"] doubleValue];
                
                myFavAnnotation.coordinate = coordinate;
                myFavAnnotation.annotationTitle = [[_dataArray objectAtIndex:[[_dataArray valueForKeyPath:@"id"] indexOfObject:[favArray objectAtIndex:i]]] objectForKey:@"name"];
                myFavAnnotation.annotationSubtitle = [[_dataArray objectAtIndex:[[_dataArray valueForKeyPath:@"id"] indexOfObject:[favArray objectAtIndex:i]]] objectForKey:@"yomi"];
                [_myMapView addAnnotation:myFavAnnotation];
                [favAnnotations addObject:myFavAnnotation];
            }            
        }
            break;
            
    //　-----------------------
    //　Visit表示ボタンタップ時
    //　-----------------------
        case 2: {
            // NSUserDefaultsからすべてのデータを取り出す
            NSDictionary *dic = [[NSUserDefaults standardUserDefaults] dictionaryRepresentation];
            // お気に入り登録した山を格納する配列を生成
            NSMutableArray *hikeArray = [[NSMutableArray alloc] init];
            
            // データベースからFAVかつYESの要素だけを抽出し、配列に登録
            for (id key in dic) {
                NSMutableString *keyName = [NSMutableString stringWithString:key];
                if ([key rangeOfString:@"KEY_HIKE_"].location != NSNotFound && [[dic objectForKey:key] boolValue] == 1 ) {
                    [keyName deleteCharactersInRange: NSMakeRange(0, 9)];
                    [hikeArray addObject:keyName];
                }
            }
            
            //お気に入り登録した山の配列から各要素を取り出し、緯度・経度の取り出しと全体地図にピン表示
            [_myMapView removeAnnotations: _myMapView.annotations];
            for(int i = 0; i < [hikeArray count]; i++){
                NSMutableArray *hikeAnnotations = [[NSMutableArray alloc] init];
                CustomAnnotation *myHikeAnnotation = [[CustomAnnotation alloc] init];
                CLLocationCoordinate2D coordinate;
                coordinate.latitude = [[[_dataArray objectAtIndex:[[_dataArray valueForKeyPath:@"id"] indexOfObject:[hikeArray objectAtIndex:i]]]
                                        objectForKey:@"mtlatitude"] doubleValue];
                coordinate.longitude = [[[_dataArray objectAtIndex:[[_dataArray valueForKeyPath:@"id"] indexOfObject:[hikeArray objectAtIndex:i]]]
                                         objectForKey:@"mtlongitude"] doubleValue];
                
                myHikeAnnotation.coordinate = coordinate;
                myHikeAnnotation.annotationTitle = [[_dataArray objectAtIndex:[[_dataArray valueForKeyPath:@"id"] indexOfObject:[hikeArray objectAtIndex:i]]] objectForKey:@"name"];
                myHikeAnnotation.annotationSubtitle = [[_dataArray objectAtIndex:[[_dataArray valueForKeyPath:@"id"] indexOfObject:[hikeArray objectAtIndex:i]]] objectForKey:@"yomi"];
                [_myMapView addAnnotation:myHikeAnnotation];
                [hikeAnnotations addObject:myHikeAnnotation];
            }
    }
            break;

        default:
            break;
    }
}

// アノテーションをタップしたときのアクション
-(void)mapView:(MKMapView *)mapView
annotationView:(MKAnnotationView *)view
calloutAccessoryControlTapped:(UIControl *)control {
    _tappedAnnotation = view.annotation.title;
    [self performSegueWithIdentifier:@"detailSegueFromMap" sender:self];
}


//　-----------------------
//　画面遷移時に遷移先のビューで必要な対応する値をセットする
//　-----------------------

- (void)prepareForSegue:(UIStoryboardSegue *)segue
                 sender:(id)sender {

    // リストから山詳細TOPビューへの遷移
    if ([[segue identifier] isEqualToString:@"detailSegue"]) {
        DetailViewController *viewController = [segue destinationViewController];
        NSInteger selectedsection = [[self.myTableView indexPathForSelectedRow] section];
        NSInteger selectedIndex = [[self.myTableView indexPathForSelectedRow] row];
        id key = [_myregKeys objectAtIndex:selectedsection];
        viewController.mtItem = [[_mydataSource objectForKey:key] objectAtIndex:selectedIndex];
                        
    }
    // 全体MAPから山詳細TOPビューへの遷移
    else if ([[segue identifier] isEqualToString:@"detailSegueFromMap"]) {
        DetailViewController *viewController = [segue destinationViewController];
        viewController.mtItem = [_dataArray objectAtIndex:[[_dataArray valueForKeyPath:@"name"] indexOfObject: _tappedAnnotation]];
    }

}


//　-----------------------
//　メモリ管理
//　-----------------------

- (void)viewDidUnload {
    [super viewDidUnload]; }

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end

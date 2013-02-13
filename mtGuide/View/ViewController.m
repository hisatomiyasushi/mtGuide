//
//  ViewController.m
//  mtGuide
//
//  Created by Hisatomi Yasushi on 13/01/09.
//  Copyright (c) 2013年 hisatomiyasushi. All rights reserved.
//

#import "ViewController.h"
#import "DetailCell.h"
#import "DetailViewController.h"
#import "CustomAnnotation.h"
#import "SharedData.h"
#import "AppDelegate.h"

@interface ViewController ()
<UITableViewDataSource, UITableViewDelegate,MKMapViewDelegate, CLLocationManagerDelegate>

@property (weak, nonatomic) IBOutlet UITableView *myTableView;
@property (weak, nonatomic) IBOutlet MKMapView *myMapView;
- (IBAction)segmentedValueChanged:(UISegmentedControl *)sender;

@end

@implementation ViewController
{
    IBOutlet UISegmentedControl *segmentedcontrol;
    NSArray *_myregKeys;
    NSArray *_dataArray;
    NSDictionary *_mydataSource;
    NSString *_tappedAnnotation;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.

    //山情報を取り出し
    SharedData *cc = [[SharedData alloc] init]; // クラス呼び出し
    [cc SetMountainsMethod]; // メソッド呼び出し
    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate]; // デリゲート呼び出し
    _myregKeys = appDelegate.myregKeys; // 代入
    _dataArray = appDelegate.dataArray; // 代入
    _mydataSource = appDelegate.mydataSource; // 代入

    [_myMapView setDelegate:self];

    self.title = @"日本百名山";
    self.myTableView.dataSource = self;
    self.myTableView.delegate = self;
    
    // 背景に画像をセットする
    UIImage *bgImage = [UIImage imageNamed:@"back.jpg"];
    self.view.backgroundColor=[UIColor colorWithPatternImage: bgImage];
    self.myTableView.backgroundColor=[UIColor colorWithPatternImage: bgImage];
    self.myMapView.backgroundColor=[UIColor colorWithPatternImage: bgImage];

    
    //一覧リストと全体地図表示切り替えボタンの初期設定
    segmentedcontrol.selectedSegmentIndex = 0;

}


//アノテーションビューが作られたときのデリゲート。addAnotationするときに呼ばれる
- (void)mapView:(MKMapView*)mapView didAddAnnotationViews:(NSArray*)views{
    // アノテーションビューを取得する
    for (MKAnnotationView* annotationView in views) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
        // コールアウトの右側のアクセサリビューにボタンを追加する
        annotationView.rightCalloutAccessoryView = button;
    }
}

- (void)viewDidUnload {
    [super viewDidUnload]; // Release any retained subviews of the main view.
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - Table View

// tableview datasource delegate methods..

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [_myregKeys count]; //セクション数（地域数）
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [_myregKeys objectAtIndex:section]; //セクション名（地域名）
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    id key = [_myregKeys objectAtIndex:section];
    return [[_mydataSource objectForKey:key] count]; //各セクションの項目数
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

//各セルの表示内容設定
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    static NSString *CellIdentififer = @"Cell";
    DetailCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentififer];
    if (!cell) {
       cell = [[DetailCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentififer];
    }

    //まずは、section番目のセクション名を抽出する
    id key = [_myregKeys objectAtIndex:indexPath.section];
    
    //セクション名のセクションにあるrow番目のデータを取り出す
    NSString *text = [[[_mydataSource objectForKey:key] objectAtIndex:indexPath.row] objectForKey:@"name"];
    NSString *subtext =  [[[_mydataSource objectForKey:key] objectAtIndex:indexPath.row] objectForKey:@"yomi"];
    cell.myLabel.text = text;
    cell.mySubLabel.text = subtext;
    cell.myImageView.image = [UIImage imageNamed:@"moutain_thumb.jpg"];
    
    return cell;
}

//セルタップデリゲートメソッド
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES]; // 選択状態の解除
}

//一覧リストと全体地図表示切り替えボタンの動作設定
- (IBAction)segmentedValueChanged:(UISegmentedControl *)sender
{
    switch (sender.selectedSegmentIndex) {
        case 0:
            self.myMapView.hidden = YES; // マップ非表示
            self.myTableView.hidden = NO; // リスト表示
            break;

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
            co.latitude = (maxLat + minLat) / 2.0; // 緯度
            co.longitude = (maxLng + minLng) / 2.0; // 経度

            MKCoordinateRegion cr = _myMapView.region;
            cr.center = co;
            cr.span.latitudeDelta = maxLat - minLat + 0.5;
            cr.span.longitudeDelta = maxLng - minLng + 0.5;
            
            [_myMapView setRegion:cr animated:YES];
        }
        
        break;

    default:
        break;
    }
}


//アノテーションをタップしたときのアクション
-(void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control{
    _tappedAnnotation = view.annotation.title;
    [self performSegueWithIdentifier:@"detailSegueFromMap" sender:self];
}


//詳細ビューに対応する文字データの値を書き込む
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"detailSegue"]) {
        DetailViewController *viewController = [segue destinationViewController];
        NSInteger selectedsection = [[self.myTableView indexPathForSelectedRow] section];
        NSInteger selectedIndex = [[self.myTableView indexPathForSelectedRow] row];
        id key = [_myregKeys objectAtIndex:selectedsection];
        viewController.mtItem = [[_mydataSource objectForKey:key] objectAtIndex:selectedIndex];
                        
    }
    else if ([[segue identifier] isEqualToString:@"detailSegueFromMap"]) {
        DetailViewController *viewController = [segue destinationViewController];
        viewController.mtItem = [_dataArray objectAtIndex:[[_dataArray valueForKeyPath:@"name"] indexOfObject: _tappedAnnotation]];
    }

}


@end

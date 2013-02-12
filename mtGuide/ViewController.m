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
//#import "AppDelegate.h" // 共通に使用する辞書を呼び出す為の追加

/*
@interface ViewController ()
{
    NSMutableArray *_objects;
}

@end
*/

@implementation ViewController

/*
- (void)awakeFromNib
{
    [super awakeFromNib];
}
*/
 
@synthesize myTableView;
@synthesize myMapView;


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    self.title = @"日本百名山";
    
    self.myTableView.dataSource = self;
    self.myTableView.delegate = self;
    
    //plistの読み込み
    NSString *path = [[NSBundle mainBundle] pathForResource:@"mtData" ofType:@"plist"];
    NSMutableArray *dataArray = [NSMutableArray arrayWithContentsOfFile:path];

    //plistからのデータの取り出し・表示    
    NSMutableArray *hokkaido = [NSMutableArray array]; //各地域毎の山々の配列
    NSMutableArray *tohoku = [NSMutableArray array];
    NSMutableArray *joshinetsu = [NSMutableArray array];
    NSMutableArray *oze = [NSMutableArray array];
    NSMutableArray *nikko = [NSMutableArray array];
    NSMutableArray *chichibu = [NSMutableArray array];
    NSMutableArray *kanto = [NSMutableArray array];
    NSMutableArray *kitaa = [NSMutableArray array];
    NSMutableArray *ontake = [NSMutableArray array];
    NSMutableArray *yatsugatake = [NSMutableArray array];
    NSMutableArray *tyuoha = [NSMutableArray array];
    NSMutableArray *minamia = [NSMutableArray array];
    NSMutableArray *hokuriku = [NSMutableArray array];
    NSMutableArray *kinki = [NSMutableArray array];
    NSMutableArray *kyushu = [NSMutableArray array];

    myregKeys = [[NSArray alloc] initWithObjects:@"北海道",@"東北",@"上信越",@"尾瀬",@"日光・足尾・上州",@"秩父・奥秩父",@"関東周辺",@"北アルプス",@"御嶽山",@"八ヶ岳・中信高原",@"中央アルプス",@"南アルプス",@"北陸",@"近畿・中国・四国",@"九州", nil]; //地域名のキー配列生成
    

    //山を各地域別にして配列の生成（後々セクション毎に分けて処理するため）
    for(int i = 0; i < [dataArray count]; i++){
        
//      myData = [dataArray valueForKeyPath:@"name"]; //キーに対応した値だけを配列全体から抽出　ただしnameだけ抽出しても意味ないので不採用。
//      myregKeys = [dataArray valueForKeyPath:@"@distinctUnionOfObjects.region"]; //重複なく地域（＝セクション）を抽出 ただし順番がばらばらになるので不採用。
        if ([[[dataArray objectAtIndex:i] objectForKey:@"region"] isEqualToString: @"北海道"]) {
            [hokkaido addObject:[dataArray objectAtIndex:i]];
        } else if ([[[dataArray objectAtIndex:i] objectForKey:@"region"] isEqualToString: @"東北"]) {
            [tohoku addObject:[dataArray objectAtIndex:i]];
        } else if ([[[dataArray objectAtIndex:i] objectForKey:@"region"] isEqualToString: @"上信越"]) {
            [joshinetsu addObject:[dataArray objectAtIndex:i]];
        } else if ([[[dataArray objectAtIndex:i] objectForKey:@"region"] isEqualToString: @"尾瀬"]) {
            [oze addObject:[dataArray objectAtIndex:i]];
        } else if ([[[dataArray objectAtIndex:i] objectForKey:@"region"] isEqualToString: @"日光・足尾・上州"]) {
            [nikko addObject:[dataArray objectAtIndex:i]];
        } else if ([[[dataArray objectAtIndex:i] objectForKey:@"region"] isEqualToString: @"秩父・奥秩父"]) {
            [chichibu addObject:[dataArray objectAtIndex:i]];
        } else if ([[[dataArray objectAtIndex:i] objectForKey:@"region"] isEqualToString: @"関東周辺"]) {
            [kanto addObject:[dataArray objectAtIndex:i]];
        } else if ([[[dataArray objectAtIndex:i] objectForKey:@"region"] isEqualToString: @"北アルプス"]) {
            [kitaa addObject:[dataArray objectAtIndex:i]];
        } else if ([[[dataArray objectAtIndex:i] objectForKey:@"region"] isEqualToString: @"御嶽山"]) {
            [ontake addObject:[dataArray objectAtIndex:i]];
        } else if ([[[dataArray objectAtIndex:i] objectForKey:@"region"] isEqualToString: @"八ヶ岳・中信高原"]) {
            [yatsugatake addObject:[dataArray objectAtIndex:i]];
        } else if ([[[dataArray objectAtIndex:i] objectForKey:@"region"] isEqualToString: @"中央アルプス"]) {
            [tyuoha addObject:[dataArray objectAtIndex:i]];
        } else if ([[[dataArray objectAtIndex:i] objectForKey:@"region"] isEqualToString: @"南アルプス"]) {
            [minamia addObject:[dataArray objectAtIndex:i]];
        } else if ([[[dataArray objectAtIndex:i] objectForKey:@"region"] isEqualToString: @"北陸"]) {
            [hokuriku addObject:[dataArray objectAtIndex:i]];
        } else if ([[[dataArray objectAtIndex:i] objectForKey:@"region"] isEqualToString: @"近畿・中国・四国"]) {
            [kinki addObject:[dataArray objectAtIndex:i]];
        } else if ([[[dataArray objectAtIndex:i] objectForKey:@"region"] isEqualToString: @"九州"]) {
            [kyushu addObject:[dataArray objectAtIndex:i]];
    }

    //各地域別山配列の配列を生成    
    NSArray *regions = [NSArray arrayWithObjects:hokkaido,tohoku,joshinetsu,oze,nikko,chichibu,kanto,kitaa,ontake,yatsugatake,tyuoha,minamia,hokuriku,kinki,kyushu, nil];
        
    //地域名のキー配列と各地域別山配列の配列を結びつけて辞書に梱包
    mydataSource = [[NSDictionary alloc] initWithObjects:regions forKeys:myregKeys]; 
       
    //緯度・経度の取り出しと全体地図にピン表示
    NSMutableArray *annotations = [[NSMutableArray alloc] init];
    CustomAnnotation *myAnnotation = [[CustomAnnotation alloc] init];
    CLLocationCoordinate2D coordinate;
    coordinate.latitude = [[[dataArray objectAtIndex:i] objectForKey:@"mtlatitude"] doubleValue];
    coordinate.longitude = [[[dataArray objectAtIndex:i] objectForKey:@"mtlongitude"] doubleValue];
    myAnnotation.coordinate = coordinate;
    myAnnotation.annotationTitle = [[dataArray objectAtIndex:i] objectForKey:@"name"];
    myAnnotation.annotationSubtitle = [[dataArray objectAtIndex:i] objectForKey:@"yomi"];
    [myMapView addAnnotation:myAnnotation];
    [annotations addObject:myAnnotation];

    }

    // 地図表示時の表示位置・縮尺を指定
    double minLat = 9999.0;
    double minLng = 9999.0;
    double maxLat = -9999.0;
    double maxLng = -9999.0;
    double lat, lng;
    
    for (id<MKAnnotation> annotation in myMapView.annotations){
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
    

    MKCoordinateRegion cr = myMapView.region;
    cr.center = co;
    cr.span.latitudeDelta = maxLat - minLat + 0.5;
    cr.span.longitudeDelta = maxLng - minLng + 0.5;
    [myMapView setRegion:cr animated:YES];
        
    
    
    //一覧リストと全体地図表示切り替えボタンの初期設定
    segmentedcontrol.selectedSegmentIndex = 0;
    

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
    return [myregKeys count]; //セクション数（地域数）
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [myregKeys objectAtIndex:section]; //セクション名（地域名）
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    id key = [myregKeys objectAtIndex:section];
    return [[mydataSource objectForKey:key] count]; //各セクションの項目数
}

//各セルの表示内容設定
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    static NSString *CellIdentififer = @"Cell";
    DetailCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentififer];
    if (!cell) {
       cell = [[DetailCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentififer];
    }

    //まずは、section番目のセクション名を抽出する
    id key = [myregKeys objectAtIndex:indexPath.section];
    
    //セクション名のセクションにあるrow番目のデータを取り出す
    NSString *text = [[[mydataSource objectForKey:key] objectAtIndex:indexPath.row] objectForKey:@"name"];
    NSString *subtext =  [[[mydataSource objectForKey:key] objectAtIndex:indexPath.row] objectForKey:@"yomi"];
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
        case 1:
            self.myMapView.hidden = NO; // マップ表示
            self.myTableView.hidden = YES; // リスト非表示
            break;
            
        default:
            break;
    }
}


//詳細ビューに対応する文字データの値を書き込む
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"detailSegue"]) {
        DetailViewController *viewController = [segue destinationViewController];
        NSInteger selectedsection = [[self.myTableView indexPathForSelectedRow] section];
        NSInteger selectedIndex = [[self.myTableView indexPathForSelectedRow] row];
        id key = [myregKeys objectAtIndex:selectedsection];
        viewController.mtStr = [[[mydataSource objectForKey:key] objectAtIndex:selectedIndex] objectForKey:@"name"];
        viewController.yomiStr = [[[mydataSource objectForKey:key] objectAtIndex:selectedIndex] objectForKey:@"yomi"];
        viewController.introStr = [[[mydataSource objectForKey:key] objectAtIndex:selectedIndex] objectForKey:@"introduction"];
        viewController.mtInformation = [[[mydataSource objectForKey:key] objectAtIndex:selectedIndex] objectForKey:@"information"];
        viewController.mtlatStr = [[[mydataSource objectForKey:key] objectAtIndex:selectedIndex] objectForKey:@"mtlatitude"];
        viewController.mtlngStr = [[[mydataSource objectForKey:key] objectAtIndex:selectedIndex] objectForKey:@"mtlongitude"];
        viewController.mttrails = [[[mydataSource objectForKey:key] objectAtIndex:selectedIndex] objectForKey:@"trails"];
        viewController.mtcamping = [[[mydataSource objectForKey:key] objectAtIndex:selectedIndex] objectForKey:@"camping"];
        
        //      NSLog(@"%@",key);
        //      NSLog(@"%d",selectedIndex);
        //      NSLog(@"%@",[mydataSource objectForKey:key]);
    }
}


@end

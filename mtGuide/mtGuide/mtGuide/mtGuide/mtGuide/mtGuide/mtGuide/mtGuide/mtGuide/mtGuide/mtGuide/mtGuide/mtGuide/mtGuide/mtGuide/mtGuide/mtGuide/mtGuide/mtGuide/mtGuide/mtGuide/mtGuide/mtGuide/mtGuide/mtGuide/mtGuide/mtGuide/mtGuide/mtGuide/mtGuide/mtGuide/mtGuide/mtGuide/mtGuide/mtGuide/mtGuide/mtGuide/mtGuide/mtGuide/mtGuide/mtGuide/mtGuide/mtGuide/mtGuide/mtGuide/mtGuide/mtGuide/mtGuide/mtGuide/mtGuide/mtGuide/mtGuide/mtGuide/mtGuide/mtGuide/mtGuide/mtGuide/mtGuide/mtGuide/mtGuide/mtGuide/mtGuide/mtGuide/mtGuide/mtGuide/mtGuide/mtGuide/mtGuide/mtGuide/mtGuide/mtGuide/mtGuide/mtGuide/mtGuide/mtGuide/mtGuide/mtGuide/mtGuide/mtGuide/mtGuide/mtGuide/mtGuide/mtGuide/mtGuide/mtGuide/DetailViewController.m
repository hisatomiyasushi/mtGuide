//
//  DetailViewController.m
//  mtGuide
//
//  Created by Hisatomi Yasushi on 13/01/10.
//  Copyright (c) 2013年 hisatomiyasushi. All rights reserved.
//

#import "DetailCell.h"
#import "ViewController.h"
#import "DetailViewController.h"
#import "InfoViewController.h"
#import "CustomAnnotation.h"
#import "InfoDetailViewController.h"
//#import "Photo.h"
//#import "FlickrPhotoParser.h"


@interface DetailViewController ()

@end

@implementation DetailViewController
@synthesize mtStr,
            introStr,
            yomiStr,
            detailTableView,
            mtInformation,
            mtlatStr,
            mtlngStr,
            detailMapView,
            mttrails,
            mtcamping;

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


//文字データ・その他を読み込み、表示する
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [detailMapView setDelegate:self];
    [self configureView];

    self.title = mtStr;
    self.detailDescriptionLabel.text = introStr;
    self.detailTableView.dataSource = self;
    self.detailTableView.delegate = self;
    
    detailData = [[NSArray alloc]initWithObjects:
                  @"山の基本情報",
                  @"登山ルート",
                  @"自然・遊び",
                  @"周辺の温泉",
                  @"キャンプ場・山小屋", nil];
    
    //詳細地図での緯度・経度の取り出しと全体地図にピン表示
    NSMutableArray *annotations=[[NSMutableArray alloc] init];
    CustomAnnotation *myAnnotation = [[CustomAnnotation alloc] init];
    CLLocationCoordinate2D coordinate;
    coordinate.latitude = [mtlatStr doubleValue];
    coordinate.longitude = [mtlngStr doubleValue];
    myAnnotation.coordinate = coordinate;
    myAnnotation.annotationTitle = mtStr;
    myAnnotation.annotationSubtitle = yomiStr;
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
    
//    NSLog(@"%f",lat);
//    NSLog(@"%f",lng);
    
    
    CLLocationCoordinate2D co;
    co.latitude = (maxLat + minLat) / 2.0; // 緯度
    co.longitude = (maxLng + minLng) / 2.0; // 経度
    
    
    MKCoordinateRegion cr = detailMapView.region;
    cr.center = co;
    cr.span.latitudeDelta = maxLat - minLat + 0.5;
    cr.span.longitudeDelta = maxLng - minLng + 0.5;
    [detailMapView setRegion:cr animated:YES];

    //詳細TOPと詳細地図表示切り替えボタンの初期設定
    detailsegmentedcontrol.selectedSegmentIndex = 0;

}

/*
 BOOL fetchPhotoDone = NO;

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
    if (!fetchPhotoDone) {
        fetchPhotoDone = YES;
        FlickrPhotoParser *parser = [[FlickrPhotoParser alloc]init];
        NSArray *photoList = [parser fetchNearbyPhotos: [newLocation coordinate]];
        for (int i=0, l=[photoList count]; i<l; i++) {
            Photo *photo = [photoList objectAtIndex:i];
            [detailMapView addAnnotation: photo];
        }
    }
}

//アノテーションをオリジナルの画像にカスタマイズ

-(MKAnnotationView*)mapView:(MKMapView*)anoMapView
          viewForAnnotation:(id <MKAnnotation>)annotation {
    
    if (annotation == anoMapView.userLocation) { //……【2】
        return nil;
    } else {
        CustomAnnotationView *annotationView;
        NSString* identifier = @"flag"; // 再利用時の識別子
        
        // 再利用可能な MKAnnotationView を取得
        annotationView = (CustomAnnotationView*)[anoMapView dequeueReusableAnnotationViewWithIdentifier:identifier];
        
        if(nil == annotationView) {
            //再利用可能な MKAnnotationView がなければ新規作成
            annotationView = [[CustomAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:identifier];
        }
        annotationView.annotation = annotation;
        return annotationView;
    }
}

*/

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Table View

// tableview datasource delegate methods..

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1; //セクション数
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [detailData count]; //項目数
}

//各セルの表示内容設定
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{        
    //さらに下層のInfoViewControllerに飛ばす予定のセルの表示内容設定
    if (indexPath.row == 0 || indexPath.row == 1 || indexPath.row == 4) {
        static NSString *CellIdentififer = @"detailCell";
        DetailCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentififer];
        cell.detailCellLabel.text = [detailData objectAtIndex:indexPath.row];
        cell.detailCellImageView.image = [UIImage imageNamed:@"kingslime.gif"];
        
        return cell;
    }
    //下層のInfoDetailViewControllerにダイレクトで飛ばす予定のセルの表示内容設定
    else {
        static NSString *CellIdentififer = @"detailCell2";
        DetailCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentififer];
        cell.detailCellLabel.text = [detailData objectAtIndex:indexPath.row];
        cell.detailCellImageView.image = [UIImage imageNamed:@"slimeknight.gif"];
        
        return cell;
    }
}


//セルタップデリゲートメソッド
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES]; // 選択状態の解除
}

//詳細TOPと詳細地図表示切り替えボタンの動作設定
- (IBAction)segmentedValueChanged:(UISegmentedControl *)sender
{
    switch (sender.selectedSegmentIndex) {
        case 0:
            self.detailMapView.hidden = YES;
            self.detailTableView.hidden = NO;
            break;
        case 1:
            self.detailMapView.hidden = NO;
            self.detailTableView.hidden = YES;
            break;
            
        default:
            break;
    }
}

//詳細ビューに対応する文字データの値を書き込む
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"infoSegue"]) {
        InfoViewController *viewController = [segue destinationViewController];
        NSInteger selectedIndex = [[self.detailTableView indexPathForSelectedRow] row];
        viewController.detailStr = [detailData objectAtIndex:selectedIndex];
        viewController.mtStr = mtStr;
        viewController.mttrails = mttrails;
        viewController.mtcamping = mtcamping;
        viewController.mtInformation = mtInformation;
    }
    if ([[segue identifier] isEqualToString:@"directinfodetailSegue"]) {
        InfoDetailViewController *viewController = [segue destinationViewController];
        NSInteger selectedIndex = [[self.detailTableView indexPathForSelectedRow] row];
        viewController.infodetailStr = [detailData objectAtIndex:selectedIndex];
    }
}



@end

//
//  InfoViewController.m
//  mtGuide
//
//  Created by Hisatomi Yasushi on 13/01/11.
//  Copyright (c) 2013年 hisatomiyasushi. All rights reserved.
//

#import "DetailViewController.h"
#import "DetailCell.h"
#import "InfoViewController.h"
#import "InfoDetailViewController.h"
#import "ViewController.h"


@interface InfoViewController ()
<UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *infoTableView;

@end

@implementation InfoViewController
{
    NSArray *_infoData;
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

#pragma mark - Managing the detail item


- (void)setDetailItem:(id)newDetailItem
{
    if (_infoItem != newDetailItem) {
        _infoItem = newDetailItem;
        
        // Update the view.
        [self configureView];
    }
}

- (void)configureView

{
    // Update the user interface for the detail item.
    
}



//文字データ・その他を読み込み、表示する
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self configureView];
    self.title = _detailStr;
    
    self.infoTableView.dataSource = self;
    self.infoTableView.delegate = self;

    // 背景に画像をセットする
    UIImage *bgImage = [UIImage imageNamed:@"back.jpg"];
    self.view.backgroundColor=[UIColor colorWithPatternImage: bgImage];
    self.infoTableView.backgroundColor=[UIColor colorWithPatternImage: bgImage];

    if ([_detailStr isEqualToString:@"山の基本情報"]) {
        _infoData = [[NSArray alloc]initWithObjects:
                @"概要",
                @"アクセス",
                @"登山適期",
//                @"登り方・楽しみ方",
                @"登山案内・管轄警察",
//                @"家族・ペット・障害者",
                     nil];
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
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_infoData count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentififer = @"infoCell";
    DetailCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentififer];
    if (!cell) {
        cell = [[DetailCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentififer];
    }
    cell.infoCellLabel.text = [_infoData objectAtIndex:indexPath.row];
    cell.infoCellImageView.image = [UIImage imageNamed:@"metalking.gif"];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES]; // 選択状態の解除
}


//詳細ビューに対応する文字データの値を書き込む

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"infodetailSegue"]) {
        InfoDetailViewController *viewController = [segue destinationViewController];
        NSInteger selectedIndex = [[self.infoTableView indexPathForSelectedRow] row];
        viewController.infodetailStr = [_infoData objectAtIndex:selectedIndex];
        viewController.mtItem = _mtItem;
    }
}



@end

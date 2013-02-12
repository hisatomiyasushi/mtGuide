//
//  SharedData.m
//  mtGuide
//
//  Created by Hisatomi Yasushi on 13/02/12.
//  Copyright (c) 2013年 hisatomiyasushi. All rights reserved.
//

#import "SharedData.h"
#import "AppDelegate.h"

@implementation SharedData
{
    NSArray *_myregKeys;
    NSArray *_dataArray;
    NSDictionary *_mydataSource;
}

- (void)SetMountainsMethod {
    //plistの読み込み
    NSString *path1 = [[NSBundle mainBundle] pathForResource:@"hokkaido" ofType:@"plist"];
    NSMutableArray *hokkaido = [NSMutableArray arrayWithContentsOfFile:path1];
    NSString *path2 = [[NSBundle mainBundle] pathForResource:@"tohoku" ofType:@"plist"];
    NSMutableArray *tohoku = [NSMutableArray arrayWithContentsOfFile:path2];
    NSString *path3 = [[NSBundle mainBundle] pathForResource:@"joshinetsu" ofType:@"plist"];
    NSMutableArray *joshinetsu = [NSMutableArray arrayWithContentsOfFile:path3];
    NSString *path4 = [[NSBundle mainBundle] pathForResource:@"oze" ofType:@"plist"];
    NSMutableArray *oze = [NSMutableArray arrayWithContentsOfFile:path4];
    NSString *path5 = [[NSBundle mainBundle] pathForResource:@"nikko" ofType:@"plist"];
    NSMutableArray *nikko = [NSMutableArray arrayWithContentsOfFile:path5];
    NSString *path6 = [[NSBundle mainBundle] pathForResource:@"chichibu" ofType:@"plist"];
    NSMutableArray *chichibu = [NSMutableArray arrayWithContentsOfFile:path6];
    NSString *path7 = [[NSBundle mainBundle] pathForResource:@"kanto" ofType:@"plist"];
    NSMutableArray *kanto = [NSMutableArray arrayWithContentsOfFile:path7];
    NSString *path8 = [[NSBundle mainBundle] pathForResource:@"kitaa" ofType:@"plist"];
    NSMutableArray *kitaa = [NSMutableArray arrayWithContentsOfFile:path8];
    NSString *path9 = [[NSBundle mainBundle] pathForResource:@"ontake" ofType:@"plist"];
    NSMutableArray *ontake = [NSMutableArray arrayWithContentsOfFile:path9];
    NSString *path10 = [[NSBundle mainBundle] pathForResource:@"yatsugatake" ofType:@"plist"];
    NSMutableArray *yatsugatake = [NSMutableArray arrayWithContentsOfFile:path10];
    NSString *path11= [[NSBundle mainBundle] pathForResource:@"tyuoha" ofType:@"plist"];
    NSMutableArray *tyuoha = [NSMutableArray arrayWithContentsOfFile:path11];
    NSString *path12 = [[NSBundle mainBundle] pathForResource:@"minamia" ofType:@"plist"];
    NSMutableArray *minamia = [NSMutableArray arrayWithContentsOfFile:path12];
    NSString *path13 = [[NSBundle mainBundle] pathForResource:@"hokuriku" ofType:@"plist"];
    NSMutableArray *hokuriku = [NSMutableArray arrayWithContentsOfFile:path13];
    NSString *path14 = [[NSBundle mainBundle] pathForResource:@"kinki" ofType:@"plist"];
    NSMutableArray *kinki = [NSMutableArray arrayWithContentsOfFile:path14];
    NSString *path15 = [[NSBundle mainBundle] pathForResource:@"kyushu" ofType:@"plist"];
    NSMutableArray *kyushu = [NSMutableArray arrayWithContentsOfFile:path15];

    //地域名（セクションとして使用）のリストを作成
    _myregKeys = [[NSArray alloc] initWithObjects:@"北海道",@"東北",@"上信越",@"尾瀬",@"日光・足尾・上州",@"秩父・奥秩父",@"関東周辺",@"北アルプス",@"御嶽山",@"八ヶ岳・中信高原",@"中央アルプス",@"南アルプス",@"北陸",@"近畿・中国・四国",@"九州", nil]; //地域名のキー配列生成
    
    //個々の山辞書の配列を生成
    _dataArray = [[[[[[[[[[[[[[hokkaido arrayByAddingObjectsFromArray:tohoku] arrayByAddingObjectsFromArray:joshinetsu] arrayByAddingObjectsFromArray:oze] arrayByAddingObjectsFromArray:nikko] arrayByAddingObjectsFromArray:chichibu] arrayByAddingObjectsFromArray:kanto] arrayByAddingObjectsFromArray:kitaa] arrayByAddingObjectsFromArray:ontake] arrayByAddingObjectsFromArray:yatsugatake] arrayByAddingObjectsFromArray:tyuoha] arrayByAddingObjectsFromArray:minamia] arrayByAddingObjectsFromArray:hokuriku] arrayByAddingObjectsFromArray:kinki] arrayByAddingObjectsFromArray:kyushu];
    
    //各地域別山配列の配列を生成
    NSArray *regions = [NSArray arrayWithObjects:hokkaido,tohoku,joshinetsu,oze,nikko,chichibu,kanto,kitaa,ontake,yatsugatake,tyuoha,minamia,hokuriku,kinki,kyushu, nil];
        
    //地域名のキー配列と各地域別山配列の配列を結びつけて辞書に梱包
    _mydataSource = [[NSDictionary alloc] initWithObjects:regions forKeys:_myregKeys];

    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate]; // デリゲート呼び出し
    appDelegate.myregKeys = _myregKeys; // デリゲートプロパティに値代入
    appDelegate.dataArray = _dataArray; // デリゲートプロパティに値代入
    appDelegate.mydataSource = _mydataSource; // デリゲートプロパティに値代入

}
@end

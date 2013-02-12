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

@interface InfoDetailViewController ()

@end

@implementation InfoDetailViewController
@synthesize infodetailStr, myTextView, gaiyouStr, txtBuffer, txtBuffer02, mtInformation, mtStr;



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

//文字データ・その他を読み込み、表示する
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    self.title = infodetailStr;
    self.infodetailLabel.text = infodetailStr;
    
    //テキストビューの初期化と編集不可に設定
    myTextView.text = @"";
    myTextView.editable = NO;

    //概要を開いたときだけwikipediaから山の概要情報を取得する
    
    if ([infodetailStr isEqualToString:@"概要"]) {
        
    //URLを指定してXMLパーサーをつくる
    NSURL *url = [[NSURL alloc] initWithString: mtInformation];
 
    NSData *data = [[NSData alloc] initWithContentsOfURL:url];
    NSXMLParser *xmlParser = [[NSXMLParser alloc] initWithData:data];

    xmlParser.delegate = self;
    
    [xmlParser parse];
        
    }
    
}


- (void) parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict {
    
    //開始タグが"text"だったら
    if ([elementName isEqualToString:@"text"]) {
        //解析タグに設定
        gaiyouStr = [NSString stringWithString:elementName];
        //テキストバッファの初期化
        txtBuffer = @"";
    }
}

                           
-(void) parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    
    //解析中のタグが"text"だったら
    if ([gaiyouStr isEqualToString:@"text"]) {
        //テキストバッファに文字を追加する
        txtBuffer = [txtBuffer stringByAppendingString:string];
    }
}


- (void) parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    
    //終了タグが"text"だったら 要素の整形を開始
    if ([elementName isEqualToString:@"text"]) {

        //正規表現のオブジェクトを生成する
        //options:0は、正規表現のmatch範囲をできるだけ狭くするように指定
        NSError *error01 = nil;
        
            NSRegularExpression *regexp01 = [[NSRegularExpression alloc] initWithPattern:@"('{3})(.|[\r\n])*?(== )"
                                                                                 options:0
                                                                                   error:&error01];//大雪山
//            NSRegularExpression *regexp01 = [[NSRegularExpression alloc] initWithPattern:@"('{3})(.|[\r\n])*(== 概要 ==)(.|[\r\n])*?(== )"
//                                                                             options:0
//                                                                               error:&error01];//大雪山
//            NSRegularExpression *regexp01 = [[NSRegularExpression alloc] initWithPattern:@"('{3})(.|[\r\n])*(== )"
//                                                                                 options:0
//                                                                                   error:&error01];//巻機山
//            NSRegularExpression *regexp01 = [[NSRegularExpression alloc] initWithPattern:@"('''富士山'''（ふじさん)(.|[\r\n])*(== 概要 ==)(.|[\r\n])*?(== )"
//                                                                                 options:0
//                                                                                   error:&error01];//富士山
            
        if (error01 != nil) {
            NSLog(@"正規表現エラーです。%@",error01);            
        } else {
            NSLog(@"regexp>>>>>%@",regexp01);
        
        
        //正規表現を対象xmlにかけてみる
        //正規表現にマッチした件数分、結果が取得できる
        NSArray *results01 = [regexp01 matchesInString:txtBuffer
                                           options:0
                                             range:NSMakeRange(0, [txtBuffer length])];
        
        
        for ( int i = 0; i <results01.count; i++){
            NSTextCheckingResult *result01 = [results01 objectAtIndex:i];
            txtBuffer02 = [txtBuffer substringWithRange:[result01 rangeAtIndex:0]];
        }        
        }
        
        
        //得られた抽出テキストから不要部分を削除するためにさらに正規表現置き換え処理
        NSError *error02 = nil;
        NSString *template = @""; //置換（＝削除）用文字列の設定
        
        NSRegularExpression *regexp02 = [[NSRegularExpression alloc] initWithPattern:@"(\'\'\'|==|概要|\\[|\\]|<ref.*?/>|<ref.*?ref>)"
                                                                             options:0
                                                                               error:&error02];
        if (error02 != nil) {
            NSLog(@"正規表現エラーです。%@",error02);            
        } else {
            
            NSString *replaced = [regexp02 stringByReplacingMatchesInString:txtBuffer02
                                             options:0
                                               range:NSMakeRange(0,txtBuffer02.length)
                                        withTemplate:template];
        
        myTextView.text = [myTextView.text stringByAppendingFormat:@"%@",replaced];
            
        }
    }
}
//}

    

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

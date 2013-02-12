//
//  WeatherSubViewController.m
//  mtGuide
//
//  Created by Hisatomi Yasushi on 13/02/05.
//  Copyright (c) 2013年 hisatomiyasushi. All rights reserved.
//

#import "WeatherSubViewController.h"
#import "UIViewController+KNSemiModal.h"
#import "DetailViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface WeatherSubViewController ()
<NSURLConnectionDataDelegate>

@end

@implementation WeatherSubViewController
{
@private
    NSMutableData *_weatherData;
    NSURLConnection *_weatherconnection;
    NSString *_tenki;
    NSString *_date;
    NSString *_lowTemp;
    NSString *_highTemp;
    NSArray *_weatherInformation;

}
@synthesize weatherLabel;
@synthesize dismissButton;
@synthesize weatherSpotKeyNumber;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
        
    //天気情報APIに接続
    
    NSString *mtUrl = [NSString stringWithFormat:@"http://weather.livedoor.com/forecast/webservice/json/v1?city=%@",weatherSpotKeyNumber];
    
    NSURL *url = [NSURL URLWithString:mtUrl];

    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    

    _weatherconnection = [NSURLConnection connectionWithRequest:request delegate:self];
    
    if (_weatherconnection) {
        _weatherData = [[NSMutableData alloc]init];
    }

}

- (void)viewDidUnload {
    [self setWeatherLabel:nil];
    [self setDismissButton:nil];
    [super viewDidUnload];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//天気情報取得
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    [_weatherData setLength:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [_weatherData appendData:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@"fail with error");
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    
    NSDictionary *allDataDictionary = [NSJSONSerialization JSONObjectWithData:_weatherData options:0 error:nil];
    
    NSArray *arrayOfEntry = [allDataDictionary objectForKey:@"forecasts"];
    NSMutableArray *weatherInformation = [NSMutableArray arrayWithCapacity:[arrayOfEntry count]];
    
    for (NSDictionary *diction in arrayOfEntry)
    {
        if ([diction objectForKey:@"telop"] != nil) {
            _tenki = [diction objectForKey:@"telop"]; //天気を取得
        }
        if ([diction objectForKey:@"date"] != nil) {
            _date = [diction objectForKey:@"date"]; //日付を取得
        }
        if ([diction  valueForKeyPath:@"temperature.min"] != nil) {
            _lowTemp = [diction valueForKeyPath:@"temperature.min.celsius"]; //最低気温を取得

        }
        if ([diction valueForKeyPath:@"temperature.max"] != nil) {
            _highTemp = [diction valueForKeyPath:@"temperature.max.celsius"]; //最高気温を取得
        }
        
        NSDictionary *prunedweatherInfo = [NSDictionary dictionaryWithObjectsAndKeys:
                                           _tenki, @"tenki",
                                           _date, @"date",
                                           _lowTemp, @"lowTemp",
                                           _highTemp, @"highTemp",
                                           nil];
        
        [weatherInformation addObject:prunedweatherInfo];
        
    }
    
    _weatherInformation = weatherInformation;
    
    for (int i = 0; i < [_weatherInformation count]; i++) {
        
        weatherLabel.text = [weatherLabel.text stringByAppendingFormat:@"%@\n%@\n最低気温：%@ 最高気温：%@\n",
                            [[_weatherInformation objectAtIndex:i] objectForKey:@"date"],
                            [[_weatherInformation objectAtIndex:i] objectForKey:@"tenki"],
                            [[_weatherInformation objectAtIndex:i] objectForKey:@"lowTemp"],
                            [[_weatherInformation objectAtIndex:i] objectForKey:@"highTemp"]];
    }

}


- (IBAction)dismissButtonDidTouch:(id)sender {
    // Here's how to call dismiss button on the parent ViewController
    // be careful with view hierarchy
    UIViewController *parent = [self.view containingViewController];
    if ([parent respondsToSelector:@selector(dismissSemiModalView)]) {
        [parent dismissSemiModalView];
    }
}

@end

//
//  WebViewController.m
//  FlickrApp
//
//  Created by Hisatomi Yasushi on 13/01/18.
//  Copyright (c) 2013年 hisatomiyasushi. All rights reserved.
//

#import "WebViewController.h"
#import "Photo.h"

@interface WebViewController ()

@end

@implementation WebViewController
@synthesize photo;
@synthesize webView;
@synthesize indicator;


- (void) openUrl : (Photo *) _photo { // ……【3】
    [indicator startAnimating];
    [self setPhoto:_photo];
    [webView loadRequest:[NSURLRequest requestWithURL:[[NSURL alloc] initWithString: [photo url]]]];
}

- (IBAction) close : (id) sender {   // ……【4】
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction) openInSafari : (id) sender {  // ……【5】
    [[UIApplication sharedApplication] openURL:[[NSURL alloc] initWithString: [photo url]]];
    
}

- (IBAction) openInExternalMap : (id) sender {  // ……【6】
    // TODO
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [webView setDelegate:self];  // ……【7】
    [indicator setHidesWhenStopped:YES];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [indicator stopAnimating];  // ……【8】
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

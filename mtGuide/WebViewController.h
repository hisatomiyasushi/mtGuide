//
//  WebViewController.h
//  FlickrApp
//
//  Created by Hisatomi Yasushi on 13/01/18.
//  Copyright (c) 2013年 hisatomiyasushi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import"Photo.h"

@interface WebViewController : UIViewController <UIWebViewDelegate>  // ……【1】
{
//    IBOutlet UIWebView *webView;  // ……【2】
//    IBOutlet UIActivityIndicatorView *indicator;
    Photo *photo;
}

@property (nonatomic, retain) Photo *photo;
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *indicator;

- (void) openUrl : (Photo *) _photo; // ……【3】
- (IBAction) close : (id) sender; // ……【4】
- (IBAction) openInSafari : (id) sender;  // ……【5】
- (IBAction) openInExternalMap : (id) sender;  // ……【6】

@end

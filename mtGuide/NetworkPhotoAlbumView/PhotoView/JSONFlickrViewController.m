//
//  JSONFlickrViewController.m
//  mtGuide
//
//  Created by Hisatomi Yasushi on 13/01/30.
//  Copyright (c) 2013年 hisatomiyasushi. All rights reserved.
//

#import "JSONFlickrViewController.h"
#import "DetailViewController.h"
#import "CaptionedPhotoView.h"
#import "AFNetworking.h"


@interface JSONFlickrViewController ()
<UITableViewDataSource,UITableViewDelegate,NSURLConnectionDataDelegate,NIPhotoAlbumScrollViewDataSource,NIPhotoScrubberViewDataSource,NIOperationDelegate>

@end

@implementation JSONFlickrViewController
{
@private
    NSString* _flickrAlbumId;
    NSArray* _photoInformation;
    NSMutableData *webData;
    NSURLConnection *connection;
    NSMutableArray *array;
    NSString *originalImageSource;
    //    NSString *thumbnailImageSource;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (id)initWith:(id)object {
    if ((self = [self initWithNibName:nil bundle:nil])) {
        self.flickrAlbumId = object;
    }
    return self;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
//- (void)loadThumbnails {
//    for (NSInteger ix = 0; ix < [_photoInformation count]; ++ix) {
//        NSDictionary* photo = [_photoInformation objectAtIndex:ix];
//
//        NSString* photoIndexKey = [self cacheKeyForPhotoIndex:ix];
//        
//        // Don't load the thumbnail if it's already in memory.
//        if (![self.thumbnailImageCache containsObjectWithName:photoIndexKey]) {
//            NSString* source = [photo objectForKey:@"thumbnailSource"];
//            [self requestImageFromSource: source
//                               photoSize: NIPhotoScrollViewPhotoSizeThumbnail
//                              photoIndex: ix];
//        }
//    }
//}

///////////////////////////////////////////////////////////////////////////////////////////////////

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    self.photoAlbumView.dataSource = self;
    self.photoScrubberView.dataSource = self;
    
    // This title will be displayed until we get the results back for the album information.
    self.title = NSLocalizedString(@"Loading...", @"Navigation bar title - Loading a photo album");
    
//    [self loadAlbumInformation];

    array = [[NSMutableArray alloc]init];

    NSString *mtName = [_mtItem objectForKey:@"name"];
    static NSString *const API_Key = @"cd10ad976306f5c6df8e5c99a94aa8af";
    NSString *mtUrlName = [mtName stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString *mtUrl = [NSString stringWithFormat:@"http://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=%@&text=%@&per_page=20&licence=1,2,3,4,5,6&format=json&nojsoncallback=1&extras=url_sq,url_t,url_s,url_q,url_m,url_n,url_z,url_c,url_l,url_o",API_Key,mtUrlName];
        
    NSURL *url = [NSURL URLWithString:mtUrl];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    connection = [NSURLConnection connectionWithRequest:request delegate:self];
    
    if (connection) {
        webData = [[NSMutableData alloc]init];
    }

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    [webData setLength:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [webData appendData:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@"fail with error");
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    
    NSDictionary *allDataDictionary = [NSJSONSerialization JSONObjectWithData:webData options:0 error:nil];

    NSDictionary *feed = [allDataDictionary objectForKey:@"photos"];
    NSArray * arrayOfEntry = [feed objectForKey:@"photo"];
    NSMutableArray* photoInformation = [NSMutableArray arrayWithCapacity:[arrayOfEntry count]];

    for (NSDictionary *diction in arrayOfEntry)
    {
        if ([diction valueForKey:@"url_l"] != nil) {
            originalImageSource = [diction objectForKey:@"url_l"];
        } else if ([diction valueForKey:@"url_c"] != nil) {
            originalImageSource = [diction objectForKey:@"url_c"];
        } else if ([diction valueForKey:@"url_z"] != nil) {
            originalImageSource = [diction objectForKey:@"url_z"];
        } else if ([diction valueForKey:@"url_m"] != nil) {
            originalImageSource = [diction objectForKey:@"url_m"];
        } else if ([diction valueForKey:@"url_n"] != nil) {
            originalImageSource = [diction objectForKey:@"url_n"];
        } else if ([diction valueForKey:@"url_q"] != nil) {
            originalImageSource = [diction objectForKey:@"url_q"];
        }

//        thumbnailImageSource = [diction objectForKey:@"url_sq"];
//        NSLog(@"thumbnailImageSource>>>>>>>>>%@", thumbnailImageSource);

        CGSize dimensions = CGSizeMake(75, 75);
        NSString* caption = [diction objectForKey:@"title"];
        NSDictionary* prunedPhotoInfo = [NSDictionary dictionaryWithObjectsAndKeys:
                                         originalImageSource, @"originalSource",
//                                         thumbnailImageSource, @"thumbnailSource",
                                         [NSValue valueWithCGSize:dimensions], @"dimensions",
                                         caption, @"caption",
                                         nil];
        
        [photoInformation addObject:prunedPhotoInfo];
//        NSLog(@"index>>>>>>>>>%@",[prunedPhotoInfo objectForKey:@"originalSource"]);

    }
    
    _photoInformation = photoInformation;

//    [self loadThumbnails];
    [self.photoAlbumView reloadData];
    [self.photoScrubberView reloadData];
    
    [self refreshChromeState];
    
    // Default Configuration Settings
    self.toolbarIsTranslucent = YES;
    self.hidesChromeWhenScrolling = YES;
    self.chromeCanBeHidden = YES;
    self.animateMovingToNextAndPreviousPhotos = NO;
    

}

///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark NIPhotoScrubberViewDataSource


///////////////////////////////////////////////////////////////////////////////////////////////////
- (NSInteger)numberOfPhotosInScrubberView:(NIPhotoScrubberView *)photoScrubberView {
    return [_photoInformation count];
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (UIImage *)photoScrubberView: (NIPhotoScrubberView *)photoScrubberView
              thumbnailAtIndex: (NSInteger)thumbnailIndex {
    NSString* photoIndexKey = [self cacheKeyForPhotoIndex:thumbnailIndex];
    
    UIImage* image = [self.thumbnailImageCache objectWithName:photoIndexKey];
    if (nil == image) {
        NSDictionary* photo = [_photoInformation objectAtIndex:thumbnailIndex];
        
        NSString* thumbnailSource = [photo objectForKey:@"thumbnailSource"];
        [self requestImageFromSource: thumbnailSource
                           photoSize: NIPhotoScrollViewPhotoSizeThumbnail
                          photoIndex: thumbnailIndex];
    }
    
    return image;
}


- (void)setChromeVisibility:(BOOL)isVisible animated:(BOOL)animated {
    [super setChromeVisibility:isVisible animated:animated];
    
    // TODO(jverkoey June 19, 2012): This is not the ideal way to do access the visible pages.
    // Let's consider adding a new API for this.
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationCurve:NIStatusBarAnimationCurve()];
    [UIView setAnimationDuration:NIStatusBarAnimationDuration()];
    for (CaptionedPhotoView* captionedPageView in self.photoAlbumView.visiblePages) {
        captionedPageView.captionWell.alpha = isVisible ? 1 : 0;
    }
    [UIView commitAnimations];
}



///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark NIPhotoAlbumScrollViewDataSource


///////////////////////////////////////////////////////////////////////////////////////////////////
- (NSInteger)numberOfPagesInPagingScrollView:(NIPhotoAlbumScrollView *)photoScrollView {
    return [_photoInformation count];
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (UIImage *)photoAlbumScrollView: (NIPhotoAlbumScrollView *)photoAlbumScrollView
                     photoAtIndex: (NSInteger)photoIndex
                        photoSize: (NIPhotoScrollViewPhotoSize *)photoSize
                        isLoading: (BOOL *)isLoading
          originalPhotoDimensions: (CGSize *)originalPhotoDimensions {
    UIImage* image = nil;

    NSString* photoIndexKey = [self cacheKeyForPhotoIndex:photoIndex];
    
    NSDictionary* photo = [_photoInformation objectAtIndex:photoIndex];
    
    // Let the photo album view know how large the photo will be once it's fully loaded.
    *originalPhotoDimensions = [[photo objectForKey:@"dimensions"] CGSizeValue];
    
    image = [self.highQualityImageCache objectWithName:photoIndexKey];
    if (nil != image) {
        *photoSize = NIPhotoScrollViewPhotoSizeOriginal;
        
    } else {
        NSString* source = [photo objectForKey:@"originalSource"];
        [self requestImageFromSource: source
                           photoSize: NIPhotoScrollViewPhotoSizeOriginal
                          photoIndex: photoIndex];
        
        *isLoading = YES;
        
        // Try to return the thumbnail image if we can.
        image = [self.thumbnailImageCache objectWithName:photoIndexKey];
        if (nil != image) {
            *photoSize = NIPhotoScrollViewPhotoSizeThumbnail;
            
        } else {
            // Load the thumbnail as well.
            NSString* thumbnailSource = [photo objectForKey:@"thumbnailSource"];
            [self requestImageFromSource: thumbnailSource
                               photoSize: NIPhotoScrollViewPhotoSizeThumbnail
                              photoIndex: photoIndex];
        }
    }
    
    return image;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)photoAlbumScrollView: (NIPhotoAlbumScrollView *)photoAlbumScrollView
     stopLoadingPhotoAtIndex: (NSInteger)photoIndex {
    // TODO: Figure out how to implement this with AFNetworking.
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (UIView<NIPagingScrollViewPage>*)pagingScrollView:(NIPagingScrollView *)pagingScrollView
                                   pageViewForIndex:(NSInteger)pageIndex {
    
    // TODO (jverkoey Nov 27, 2011): We should make this sort of custom logic easier to build.
    UIView<NIPagingScrollViewPage>* pageView = nil;
    NSString* reuseIdentifier = NSStringFromClass([CaptionedPhotoView class]);
    pageView = [pagingScrollView dequeueReusablePageWithIdentifier:reuseIdentifier];
    if (nil == pageView) {
        pageView = [[CaptionedPhotoView alloc] init];
        pageView.reuseIdentifier = reuseIdentifier;

    }
    
    NIPhotoScrollView* photoScrollView = (NIPhotoScrollView *)pageView;
    photoScrollView.photoScrollViewDelegate = self.photoAlbumView;
    photoScrollView.zoomingAboveOriginalSizeIsEnabled = [self.photoAlbumView isZoomingAboveOriginalSizeEnabled];
    
    CaptionedPhotoView* captionedView = (CaptionedPhotoView *)pageView;
    captionedView.caption = [[_photoInformation objectAtIndex:pageIndex] objectForKey:@"caption"];


    return pageView;

}


- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    // restore *bar opacity
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleBlackOpaque;
    
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    self.navigationController.navigationBar.translucent = NO;
    
    self.navigationController.toolbar.barStyle = UIBarStyleBlack;
    self.navigationController.toolbar.translucent = NO;
}




@end

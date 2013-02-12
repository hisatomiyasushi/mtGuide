//
//  JSONFlickrViewController.m
//  mtGuide
//
//  Created by Hisatomi Yasushi on 13/01/28.
//  Copyright (c) 2013年 hisatomiyasushi. All rights reserved.
//

#import "JSONFlickrViewController.h"
#import "SBJson.h"
#import "SBJsonWriter.h"

@interface JSONFlickrViewController ()

@end

NSString *const FlickrAPIKey = @"cd10ad976306f5c6df8e5c99a94aa8af";


@implementation JSONFlickrViewController

/*
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
*/


/**************************************************************************
 *
 * Private implementation section
 *
 **************************************************************************/

#pragma mark -
#pragma mark Private Methods

/*-------------------------------------------------------------
 *
 *------------------------------------------------------------*/
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    // Store incoming data into a string
	NSString *jsonString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
    // Create a dictionary from the JSON string
	NSDictionary *results = [jsonString JSONValue];
	
    // Build an array from the dictionary for easy access to each entry
	NSArray *photos = [[results objectForKey:@"photos"] objectForKey:@"photo"];
    
    // Loop through each entry in the dictionary...
	for (NSDictionary *photo in photos)
    {
        // Get title of the image
		NSString *title = [photo objectForKey:@"title"];
        
        // Save the title to the photo titles array
		[photoTitles addObject:(title.length > 0 ? title : @"Untitled")];
		
        // Build the URL to where the image is stored (see the Flickr API)
        // In the format http://farmX.static.flickr.com/server/id/secret
        // Notice the "_s" which requests a "small" image 75 x 75 pixels
		NSString *photoURLString = [NSString stringWithFormat:@"http://farm%@.static.flickr.com/%@/%@_%@_s.jpg", [photo objectForKey:@"farm"], [photo objectForKey:@"server"], [photo objectForKey:@"id"], [photo objectForKey:@"secret"]];
        
        debug(@"photoURLString: %@", photoURLString);
        
        // The performance (scrolling) of the table will be much better if we
        // build an array of the image data here, and then add this data as
        // the cell.image value (see cellForRowAtIndexPath:)
		[photoSmallImageData addObject:[NSData dataWithContentsOfURL:[NSURL URLWithString:photoURLString]]];
        
        // Build and save the URL to the large image so we can zoom
        // in on the image if requested
		photoURLString = [NSString stringWithFormat:@"http://farm%@.static.flickr.com/%@/%@_%@_m.jpg", [photo objectForKey:@"farm"], [photo objectForKey:@"server"], [photo objectForKey:@"id"], [photo objectForKey:@"secret"]];
		[photoURLsLargeImage addObject:[NSURL URLWithString:photoURLString]];
        
        debug(@"photoURLsLareImage: %@\n\n", photoURLString); 
	}
    
}


/*-------------------------------------------------------------
 *
 *------------------------------------------------------------*/
- (void)searchFlickrPhotos:(NSString *)text
{
    // Build the string to call the Flickr API
	NSString *urlString = [NSString stringWithFormat:@"http://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=%@&tags=%@&per_page=15&format=json&nojsoncallback=1", FlickrAPIKey, text];
    
    // Create NSURL string from formatted string
	NSURL *url = [NSURL URLWithString:urlString];
    
    // Setup and start async download
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL: url];
    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
}


/**************************************************************************
 *
 * Class implementation section
 *
 **************************************************************************/

#pragma mark -
#pragma mark Initialization

/*-------------------------------------------------------------
 *
 *------------------------------------------------------------*/
- (id)init
{
    if (self = [super init])
    {
        self.view = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame]];
        
        // Initialize our arrays
		photoTitles = [[NSMutableArray alloc] init];
		photoSmallImageData = [[NSMutableArray alloc] init];
		photoURLsLargeImage = [[NSMutableArray alloc] init];
        
        // Notice that I am hard-coding the search tag at this point (@"iPhone")
        [self searchFlickrPhotos:@"大雪山"];
        
    }
	return self;
    
}


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

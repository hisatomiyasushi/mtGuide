//
//  FlickrPhotoParser.m
//  mtGuide
//
//  Created by Hisatomi Yasushi on 13/01/19.
//  Copyright (c) 2013年 hisatomiyasushi. All rights reserved.
//

#import "FlickrPhotoParser.h"

@implementation FlickrPhotoParser

@synthesize list;

static NSString *API_KEY = @"cd10ad976306f5c6df8e5c99a94aa8af"; //……【1】

- (NSArray*) fetchNearbyPhotos: (CLLocationCoordinate2D) centerCoordinate { //……【2】
    NSString* urlString = [NSString stringWithFormat:@"http://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=%@&lat=%f&lon=%f&extras=geo,url_t,owner_name",
                           API_KEY, centerCoordinate.latitude, centerCoordinate.longitude];
    NSLog(@"%@",urlString);
    list = [[NSMutableArray alloc]init];
    NSXMLParser *parser = [[NSXMLParser alloc] initWithContentsOfURL:[NSURL URLWithString:urlString]];   //……【3】
    [parser setDelegate:self];   //このクラスでイベントをハンドルできるようにする
    [parser setShouldProcessNamespaces:NO];
    [parser setShouldReportNamespacePrefixes:NO];
    [parser setShouldResolveExternalEntities:NO];
    [parser parse];  //……【4】
    
    return list;
}

- (void)parserDidStartDocument:(NSXMLParser *)parser {   //……【5】
    list = [[NSMutableArray alloc]init];
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI
 qualifiedName:(NSString *)qName
    attributes:(NSDictionary *)attributeDict {
    if ([@"photo" isEqualToString:elementName]) { //……【6】
        Photo *photo = [[Photo alloc]init];
        [photo setOwner:(NSString*)[attributeDict objectForKey:@"owner"]];
        [photo setOwnerName:(NSString*)[attributeDict objectForKey:@"ownername"]];
        [photo setPhotoId:(NSString*)[attributeDict objectForKey:@"id"]];
        [photo setTitle:(NSString*)[attributeDict objectForKey:@"title"]];
        [photo setCoordinate: CLLocationCoordinate2DMake([(NSString*)[attributeDict objectForKey:@"latitude"] floatValue],
                                                         [(NSString*)[attributeDict objectForKey:@"longitude"] floatValue])];
        [photo setThumbUrl:(NSString*)[attributeDict objectForKey:@"url_t"]];
        [list addObject:photo];
    }
}


@end

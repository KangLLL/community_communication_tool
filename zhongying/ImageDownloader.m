//
//  ImageDownloader.m
//  zhongying
//
//  Created by lik on 14-3-28.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import "ImageDownloader.h"

@implementation ImageDownloader

- (NSString *)getUrl
{
    return imageUrl;
}

- (void)downloadImage:(NSString *)url withDelegate:(id<ImageDownloaderDelegate>)delegate
{
    connection = [NSURLConnection connectionWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url]] delegate:self];
    imageUrl = url;
    currentDelegate = delegate;
}

- (void)stopDownload
{
    currentDelegate = nil;
}

#pragma mark - Connection Data Delegate
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    imageData = [NSMutableData data];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [imageData appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    if(currentDelegate != nil){
        [currentDelegate imageDownloaderDownload:self downloadFinished:imageData];
    }
}

#pragma mark - Connection Delegate
-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    if(currentDelegate != nil){
        [currentDelegate imageDownloaderDownload:self encounterError:error];
    }
}

@end

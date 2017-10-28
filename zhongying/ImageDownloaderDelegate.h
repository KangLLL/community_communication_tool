//
//  ImageDownloaderDelegate.h
//  zhongying
//
//  Created by lik on 14-3-28.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ImageDownloader;

@protocol ImageDownloaderDelegate <NSObject>

- (void)imageDownloaderDownload:(ImageDownloader *)downloader encounterError:(NSError *)error;
- (void)imageDownloaderDownload:(ImageDownloader *)downloader downloadFinished:(NSData *)result;

@end

//
//  ImageDownloader.h
//  zhongying
//
//  Created by lik on 14-3-28.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ImageDownloaderDelegate.h"

@interface ImageDownloader : NSObject<NSURLConnectionDataDelegate,NSURLConnectionDelegate>{
    NSMutableData *imageData;
    NSURLConnection *connection;
    id<ImageDownloaderDelegate> currentDelegate;
    NSString *imageUrl;
}

- (void)downloadImage:(NSString *)url withDelegate:(id<ImageDownloaderDelegate>)delegate;
- (NSString *)getUrl;
- (void)stopDownload;

@end

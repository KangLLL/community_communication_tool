//
//  DownloadCacher.h
//  zhongying
//
//  Created by apple on 14-4-13.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ImageDownloader.h"

@interface DownloadCacher : NSObject<ImageDownloaderDelegate>{
    NSMutableDictionary *alreadyDownloadedImage;
    NSMutableDictionary *downloadingImage;
}

- (void)getImageWithUrl:(NSString *)url andCell:(UITableViewCell *)cell inImageView:(UIImageView *)imageView withActivityView:(UIActivityIndicatorView *)activityView;

@end

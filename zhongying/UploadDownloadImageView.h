//
//  UploadDownloadImageView.h
//  zhongying
//
//  Created by lk on 14-4-27.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ImageDownloader.h"

@interface UploadDownloadImageView : UIView<ImageDownloaderDelegate>{
    int currentImageIndex;
    NSMutableDictionary *downloadViews;
    NSMutableDictionary *downloadActivities;
}

@property (strong) IBOutlet UIImageView *image1;
@property (strong) IBOutlet UIImageView *image2;
@property (strong) IBOutlet UIImageView *image3;
@property (strong) IBOutlet UIActivityIndicatorView *activity1;
@property (strong) IBOutlet UIActivityIndicatorView *activity2;
@property (strong) IBOutlet UIActivityIndicatorView *activity3;

- (void)uploadLocalImage:(UIImage *)image;
- (void)downloadServerImage:(NSArray *)imageUrls;
- (BOOL)canUploadMore;
- (NSArray *)getUploadImageInformations;

@end

//
//  UploadDownloadImageView.m
//  zhongying
//
//  Created by lk on 14-4-27.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import "UploadDownloadImageView.h"
#import "ImageInformation.h"
#import "CommonUtilities.h"

@implementation UploadDownloadImageView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (BOOL)canUploadMore
{
    return currentImageIndex < 3;
}

- (void)uploadLocalImage:(UIImage *)image
{
    if(currentImageIndex == 0){
        self.image1.image = image;
        self.image2.image = nil;
        self.image3.image = nil;
        
        self.activity1.hidden = YES;
        self.activity2.hidden = YES;
        self.activity3.hidden = YES;
    }
    else if(currentImageIndex == 1){
        self.image2.image = image;
    }
    else{
        self.image3.image = image;
    }
    currentImageIndex ++;
}

- (NSArray *)getUploadImageInformations
{
    NSMutableArray *result = [NSMutableArray array];
    if(currentImageIndex == 0){
        return nil;
    }
    if(currentImageIndex >= 1){
        ImageInformation *image = [[ImageInformation alloc] init];
        image.imageData = UIImageJPEGRepresentation(self.image1.image, 0.5);
        image.fileName = @"1.jpg";
        [result addObject:image];
        if(currentImageIndex >= 2){
            ImageInformation *image = [[ImageInformation alloc] init];
            image.imageData = UIImageJPEGRepresentation(self.image2.image, 0.5);
            image.fileName = @"2.jpg";
            [result addObject:image];
            if(currentImageIndex >= 3){
                ImageInformation *image = [[ImageInformation alloc] init];
                image.imageData = UIImageJPEGRepresentation(self.image3.image, 0.5);
                image.fileName = @"3.jpg";
                [result addObject:image];
            }
        }
    }
    return result;
}

- (void)downloadServerImage:(NSArray *)imageUrls
{
    downloadViews = [NSMutableDictionary dictionary];
    downloadActivities = [NSMutableDictionary dictionary];
    
    if([imageUrls count] >= 1){
        NSString *url = [imageUrls objectAtIndex:0];
        ImageDownloader *downloader = [[ImageDownloader alloc] init];
        [downloader downloadImage:url withDelegate:self];
        [self.activity1 startAnimating];
        [downloadViews setObject:self.image1 forKey:url];
        [downloadActivities setObject:self.activity1 forKey:url];
        if([imageUrls count] >= 2){
            NSString *url = [imageUrls objectAtIndex:1];
            ImageDownloader *downloader = [[ImageDownloader alloc] init];
            [downloader downloadImage:url withDelegate:self];
            [self.activity2 startAnimating];
            [downloadViews setObject:self.image2 forKey:url];
            [downloadActivities setObject:self.activity2 forKey:url];
            if([imageUrls count] >= 3){
                NSString *url = [imageUrls objectAtIndex:2];
                ImageDownloader *downloader = [[ImageDownloader alloc] init];
                [downloader downloadImage:url withDelegate:self];
                [self.activity3 startAnimating];
                [downloadViews setObject:self.image3 forKey:url];
                [downloadActivities setObject:self.activity3 forKey:url];
            }
        }
    }
    
    if([imageUrls count] == 0){
        self.image1.hidden = YES;
        self.activity1.hidden = YES;
        self.image2.hidden = YES;
        self.activity2.hidden = YES;
        self.image3.hidden = YES;
        self.activity3.hidden = YES;
    }
    else if([imageUrls count] == 1){
        self.image2.hidden = YES;
        self.activity2.hidden = YES;
        self.image3.hidden = YES;
        self.activity3.hidden = YES;
    }
    else if([imageUrls count] == 2){
        self.image3.hidden = YES;
        self.activity3.hidden = YES;
    }
}


#pragma mark - Image Download Delegate

- (void)imageDownloaderDownload:(ImageDownloader *)downloader downloadFinished:(NSData *)result
{
    NSString *key = [downloader getUrl];
    UIImageView *imageView = [downloadViews objectForKey:key];
    imageView.image = [UIImage imageWithData:result];
    UIActivityIndicatorView *activityView = [downloadActivities objectForKey:key];
    activityView.hidden = YES;
}

- (void)imageDownloaderDownload:(ImageDownloader *)downloader encounterError:(NSError *)error
{
    [[CommonUtilities instance] showGlobeMessage:error.localizedDescription];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end

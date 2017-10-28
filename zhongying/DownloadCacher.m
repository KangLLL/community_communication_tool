//
//  DownloadCacher.m
//  zhongying
//
//  Created by apple on 14-4-13.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import "DownloadCacher.h"
#import "DownloadCellInformation.h"

@implementation DownloadCacher

- (id)init
{
    if(self = [super init]){
        alreadyDownloadedImage = [NSMutableDictionary dictionary];
        downloadingImage = [NSMutableDictionary dictionary];
    }
    return self;
}

#pragma mark - Public Methods

- (void)getImageWithUrl:(NSString *)url andCell:(UITableViewCell *)cell inImageView:(UIImageView *)imageView withActivityView:(UIActivityIndicatorView *)activityView;
{
    if([alreadyDownloadedImage.allKeys containsObject:url]){
        UIImage *image = [alreadyDownloadedImage objectForKey:url];
        imageView.image = image;
        if(activityView != nil){
            activityView.hidden = YES;
        }
    }
    else{
        if(activityView != nil){
            activityView.hidden = NO;
            [activityView startAnimating];
        }
        imageView.image = nil;
        if([downloadingImage.allKeys containsObject:url]){
            NSMutableArray *array = [downloadingImage objectForKey:url];
            DownloadCellInformation *info = [[DownloadCellInformation alloc] init];
            if(cell != nil){
                info.cell = cell;
                info.initialId = cell.tag;
            }
            info.relatedImageView = imageView;
            info.activityView = activityView;
            [array addObject:info];
        }
        else{
            DownloadCellInformation *info = [[DownloadCellInformation alloc] init];
            if(cell != nil){
                info.cell = cell;
                info.initialId = cell.tag;
            }
            info.relatedImageView = imageView;
            info.activityView = activityView;
            NSMutableArray *array = [NSMutableArray arrayWithObject:info];
            [downloadingImage setObject:array forKey:url];
            ImageDownloader *downloader = [[ImageDownloader alloc] init];
            [downloader downloadImage:url withDelegate:self];
        }
    }
}

#pragma mark - Image Delegate

- (void)imageDownloaderDownload:(ImageDownloader *)downloader encounterError:(NSError *)error
{
    NSString *url = [downloader getUrl];
    for (DownloadCellInformation *info in [downloadingImage objectForKey:url]){
        if(info.cell == nil || info.cell.tag == info.initialId){
            if(info.activityView != nil){
                info.activityView.hidden = YES;
            }
        }
    }
    [downloadingImage removeObjectForKey:url];
}

- (void)imageDownloaderDownload:(ImageDownloader *)downloader downloadFinished:(NSData *)result
{
    NSString *url = [downloader getUrl];
    if([downloadingImage.allKeys containsObject:url]){
        
        UIImage *image = [[UIImage alloc] initWithData:result];
        if(image != nil)
        {
            [alreadyDownloadedImage setObject:image forKey:url];
        }
        for (DownloadCellInformation *info in [downloadingImage objectForKey:url]) {
            if(info.cell == nil || info.cell.tag == info.initialId){
                if(info.relatedImageView != nil){
                    info.relatedImageView.image = image;
                }
                if(info.activityView != nil){
                    info.activityView.hidden = YES;
                }
            }
        }
        [downloadingImage removeObjectForKey:url];
    }
}
@end

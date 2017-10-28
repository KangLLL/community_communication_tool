//
//  AdvertisementView.h
//  zhongying
//
//  Created by lk on 14-5-29.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GetAdvertisementsResponseParameter.h"
#import "DownloadCacher.h"

@interface AdvertisementView : UIView<UIScrollViewDelegate>{
    NSMutableArray *pages;
    NSTimer *autoPageTimer;
    DownloadCacher *cacher;
    
    NSMutableDictionary *advertisementUrls;
}

- (void)displayAdvertiseWithImages:(NSArray *)array;
- (void)displayAdvertiseWithAdvertisementResponse:(GetAdvertisementsResponseParameter *)response;

- (int)currentDisplayPage;

@property (strong) IBOutlet UIScrollView *container;
@property (strong) IBOutlet UIPageControl *pageControl;


@end

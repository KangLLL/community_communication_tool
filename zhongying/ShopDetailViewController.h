//
//  ShopDetailViewController.h
//  zhongying
//
//  Created by lk on 14-4-21.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import "ZhongYingBaseViewController.h"
#import "CommunicationManager.h"
#import "ShopDetailResponseParameter.h"
#import "ShopParameter.h"
#import "ImageDownloader.h"

@interface ShopDetailViewController : ZhongYingBaseViewController<CommunicationDelegate, ImageDownloaderDelegate>{
    ShopDetailResponseParameter *currentResponse;
    ImageDownloader *photoDownloader;
}

@property (strong) IBOutlet UILabel *labelTitle;
@property (strong) IBOutlet UILabel *labelName;
@property (strong) IBOutlet UILabel *labelCategory;
@property (strong) IBOutlet UILabel *labelBusinessHour;
@property (strong) IBOutlet UILabel *labelPhone;
@property (strong) IBOutlet UILabel *labelAddress;

@property (strong) IBOutlet UIImageView *imagePhoto;
@property (strong) IBOutlet UIActivityIndicatorView *activityView;
@property (strong) IBOutlet UIWebView *webDetail;

@property (strong) ShopParameter *shop;

- (IBAction)dailPhone:(id)sender;
- (IBAction)findInMap:(id)sender;

@end

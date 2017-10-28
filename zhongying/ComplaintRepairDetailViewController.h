//
//  ComplaintRepairDetailViewController.h
//  zhongying
//
//  Created by lk on 14-4-26.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import "ZhongYingBaseViewController.h"
#import "CommunicationManager.h"
#import "ComplaintDetailResponseParameter.h"
#import "RepairDetailResponseParameter.h"
#import "RepairParameter.h"
#import "ComplaintParameter.h"
#import "ImageDownloader.h"

@interface ComplaintRepairDetailViewController : ZhongYingBaseViewController<CommunicationDelegate, ImageDownloaderDelegate>{
    ComplaintDetailResponseParameter *currentComplaint;
    RepairDetailResponseParameter *currentRepair;
}

@property (strong) IBOutlet UILabel *labelTypeTitle;
@property (strong) IBOutlet UIImageView *imageHandle;
@property (strong) IBOutlet UIImageView *iamgeUnhandle;
@property (strong) IBOutlet UILabel *labelName;
@property (strong) IBOutlet UILabel *labelTitle;
@property (strong) IBOutlet UILabel *labelContent;
@property (strong) IBOutlet UILabel *labelTime;
@property (strong) IBOutlet UILabel *labelComment;

@property (strong) IBOutlet NSLayoutConstraint *bottomConstraints;
@property (strong) IBOutlet UIView *viewImages;

@property (strong) IBOutlet UIImageView *imageView1;
@property (strong) IBOutlet UIActivityIndicatorView *activityView1;
@property (strong) IBOutlet UIImageView *imageView2;
@property (strong) IBOutlet UIActivityIndicatorView *activityView2;
@property (strong) IBOutlet UIImageView *imageView3;
@property (strong) IBOutlet UIActivityIndicatorView *activityView3;

@property (strong) RepairParameter *repair;
@property (strong) ComplaintParameter *complaint;

@end

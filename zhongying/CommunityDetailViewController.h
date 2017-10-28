//
//  CommunityDetailViewController.h
//  zhongying
//
//  Created by lk on 14-5-25.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import "ZhongYingBaseViewController.h"
#import "CommunicationManager.h"
#import "ImageDownloader.h"
#import "SelectFoldableView.h"

@interface CommunityDetailViewController : ZhongYingBaseViewController<CommunicationDelegate,ImageDownloaderDelegate,FoldableViewDataDelegate, FoldableViewDelegate>{
    ImageDownloader *photoDownloader;
    CGFloat photoInitialHeight;
}

@property (strong) IBOutlet UIImageView *imagePhoto;
@property (strong) IBOutlet UILabel *labelTitle;
@property (strong) IBOutlet UILabel *labelName;
@property (strong) IBOutlet UILabel *labelBuildTime;
@property (strong) IBOutlet UILabel *labelFinishTime;
@property (strong) IBOutlet UILabel *labelBuildCompany;
@property (strong) IBOutlet UILabel *labelPropertyAdress;
@property (strong) IBOutlet UILabel *labelPropertyPrice;
@property (strong) IBOutlet UILabel *labelPropertyPhone;
@property (strong) IBOutlet UILabel *labelComplaintPhone;
@property (strong) IBOutlet UIWebView *webDescription;

@property (strong) IBOutlet SelectFoldableView *communityView;
@property (strong) IBOutlet UIButton *buttonGetMore;

@property (strong) IBOutlet NSLayoutConstraint *photoHeight;

- (IBAction)getMore:(id)sender;

@end

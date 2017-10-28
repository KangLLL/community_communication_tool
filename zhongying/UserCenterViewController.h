//
//  UserCenterViewController.h
//  zhongying
//
//  Created by lik on 14-3-28.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import "ZhongYingBaseViewController.h"
#import "ImageDownloader.h"
#import "CommunicationManager.h"

@interface UserCenterViewController : ZhongYingBaseViewController<UITableViewDataSource, UITableViewDelegate,ImageDownloaderDelegate,UIImagePickerControllerDelegate, UINavigationControllerDelegate,CommunicationDelegate, UIAlertViewDelegate>{
    UIImage *localAvatar;
    UIImageView *imageAvatar;
    UIActivityIndicatorView *activityView;
    
    ImageDownloader *avatarDownloader;
    UITableView *tableOptions;
    
    CGRect windowFrame;
    CGRect windowBounds;
    UIWindow *window;
}

@property (strong) IBOutlet UITableView *tableItems;
@property (strong) IBOutlet UIView *viewMask;

- (IBAction)editAvatar:(id)sender;

@end

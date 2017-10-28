//
//  AboutViewController.h
//  zhongying
//
//  Created by lk on 14-4-14.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import "ZhongYingBaseViewController.h"
#import <MessageUI/MessageUI.h>
#import <Social/Social.h>

@interface AboutViewController : ZhongYingBaseViewController<MFMessageComposeViewControllerDelegate, MFMailComposeViewControllerDelegate,UITableViewDataSource, UITableViewDelegate>{
    UITableView *tableOptions;
    //SLComposeViewController *weiboController;
}

@property (strong) IBOutlet UIButton *buttonUrl;
@property (strong) IBOutlet UIButton *buttonPhone;
@property (strong) IBOutlet UIView *viewConnect;

@property (strong) IBOutlet UIView *viewMask;

- (IBAction)toHomePage:(id)sender;
- (IBAction)dialPhone:(id)sender;
- (IBAction)share:(id)sender;
- (IBAction)checkUpdate:(id)sender;

@end

//
//  NotificationDetailViewController.h
//  zhongying
//
//  Created by lik on 14-4-10.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import "ZhongYingBaseViewController.h"

#import "NotificationParameter.h"
#import "CommunicationManager.h"

@interface NotificationDetailViewController : ZhongYingBaseViewController<CommunicationDelegate>

@property (strong) IBOutlet UILabel *labelTitle;
@property (strong) IBOutlet UILabel *labelTime;
@property (strong) IBOutlet UIScrollView *scrollContent;

@property (strong) NotificationParameter *notification;

@end

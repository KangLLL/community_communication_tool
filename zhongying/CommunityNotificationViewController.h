//
//  CommunityNotificationViewController.h
//  zhongying
//
//  Created by lik on 14-3-23.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZhongYingBaseViewController.h"
#import "CommunicationDelegate.h"

@interface CommunityNotificationViewController : ZhongYingBaseViewController<UITableViewDataSource, UITableViewDelegate>

@property (strong) IBOutlet UILabel *labelTitle;
@property (strong) IBOutlet UILabel *labelTime;
@property (strong) IBOutlet UILabel *labelAuthorName;

@end

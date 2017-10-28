//
//  AdminMessageDetailViewController.h
//  zhongying
//
//  Created by lk on 14-5-27.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import "ZhongYingBaseViewController.h"
#import "CommunicationManager.h"
#import "AdminMessageParameter.h"

@interface AdminMessageDetailViewController : ZhongYingBaseViewController<CommunicationDelegate>

@property (strong) IBOutlet UILabel *labelTitle;
@property (strong) IBOutlet UILabel *labelTime;
@property (strong) IBOutlet UIScrollView *scrollContent;

@property (strong) AdminMessageParameter *adminMessage;

@end

//
//  MessageViewController.h
//  zhongying
//
//  Created by lk on 14-4-15.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import "ZhongYingBaseViewController.h"
#import "CommunicationManager.h"
#import "GetUnreadNotificationResponseParameter.h"

@interface MessageViewController : ZhongYingBaseViewController<CommunicationDelegate,UITableViewDataSource, UITableViewDelegate>{
    GetUnreadNotificationResponseParameter *currentResponse;
}

@property (strong) IBOutlet UITableView *tableInformations;

@end

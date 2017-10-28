//
//  AdminMessageViewController.h
//  zhongying
//
//  Created by lk on 14-5-27.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import "ZhongYingBaseViewController.h"
#import "CommunicationManager.h"
#import "PageDataManager.h"
#import "EGORefreshTableHeaderView.h"
#import "GetAdminMessageResponseParameter.h"

@interface AdminMessageViewController : ZhongYingBaseViewController<UITableViewDataSource, UITableViewDelegate, CommunicationDelegate,EGORefreshTableHeaderDelegate>{
    GetAdminMessageResponseParameter *currentResponse;
    int currentSelectIndex;
    
    EGORefreshTableHeaderView *refreshHeaderView;
    PageDataManager *messageDataManager;
    BOOL isReloading;
}

@property (strong) IBOutlet UITableView *tableInformations;

@end

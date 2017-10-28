//
//  MoneyLogViewController.h
//  zhongying
//
//  Created by lk on 14-4-25.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import "ZhongYingBaseViewController.h"
#import "CommunicationManager.h"
#import "GetMoneyLogResponseParameter.h"
#import "EGORefreshTableHeaderView.h"
#import "PageDataManager.h"

@interface MoneyLogViewController : ZhongYingBaseViewController<UITableViewDataSource, UITableViewDelegate, CommunicationDelegate, EGORefreshTableHeaderDelegate>{
    GetMoneyLogResponseParameter *currentResponse;
    
    EGORefreshTableHeaderView *refreshHeaderView;
    PageDataManager *logsDataManager;
    BOOL isReloading;
}

@property (strong) IBOutlet UITableView *tableInformations;
@property (strong) IBOutlet UILabel *labelRemainingMoney;

@end

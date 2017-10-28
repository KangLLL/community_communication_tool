//
//  OrderViewController.h
//  zhongying
//
//  Created by lk on 14-4-24.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import "ZhongYingBaseViewController.h"
#import "CommunicationManager.h"
#import "GetOrdersResponseParameter.h"
#import "EGORefreshTableHeaderView.h"
#import "PageDataManager.h"

@interface OrderViewController : ZhongYingBaseViewController<UITableViewDataSource, UITableViewDelegate, CommunicationDelegate,EGORefreshTableHeaderDelegate>{
    GetOrdersResponseParameter *currentResponse;
    NSInteger currentSelectIndex;
    
    EGORefreshTableHeaderView *refreshHeaderView;
    PageDataManager *orderDataManager;
    BOOL isReloading;
}

@property (strong) IBOutlet UITableView *tableInformations;

@end

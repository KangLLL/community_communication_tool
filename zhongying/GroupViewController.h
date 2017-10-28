//
//  GroupViewController.h
//  zhongying
//
//  Created by LI K on 12/4/14.
//  Copyright (c) 2014 lik. All rights reserved.
//

#import "ZhongYingBaseViewController.h"
#import "CommunicationDelegate.h"
#import "GetGroupsResponseParameter.h"
#import "DownloadCacher.h"
#import "EGORefreshTableHeaderView.h"
#import "PageDataManager.h"

@interface GroupViewController : ZhongYingBaseViewController<UITableViewDataSource, UITableViewDelegate, CommunicationDelegate, EGORefreshTableHeaderDelegate>{
    GetGroupsResponseParameter *currentResponse;
    DownloadCacher *cacher;
    
    NSInteger currentSelectIndex;
    EGORefreshTableHeaderView *refreshHeaderView;
    PageDataManager *dataManager;
    BOOL isReloading;
}

@property (strong) IBOutlet UITableView *tableInformations;
@property (strong) IBOutlet UILabel *labelTitle;
@property (assign) BOOL isGroup;

@end

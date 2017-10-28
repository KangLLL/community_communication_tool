//
//  NotificationViewController.h
//  zhongying
//
//  Created by lik on 14-4-10.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import "ZhongYingBaseViewController.h"
#import "SelectFoldableView.h"
#import "CommunicationDelegate.h"
#import "GetNotificationResponseParameter.h"
#import "EGORefreshTableHeaderView.h"
#import "PageDataManager.h"

@interface NotificationViewController : ZhongYingBaseViewController<FoldableViewDataDelegate, FoldableViewDelegate, UITableViewDataSource, UITableViewDelegate, CommunicationDelegate,EGORefreshTableHeaderDelegate>{
    GetNotificationResponseParameter *currentNotifications;
    int currentSelectIndex;
    EGORefreshTableHeaderView *refreshHeaderView;
    PageDataManager *notificationDataManager;
    BOOL isReloading;
}


@property (strong) IBOutlet UILabel *labelCommunityName;

@property (strong) IBOutlet UITableView *tableInformations;
@property (strong) IBOutlet SelectFoldableView *communitiesView;

@property (strong) IBOutlet NSLayoutConstraint *tableHeight;

- (IBAction)getMore:(id)sender;

@end

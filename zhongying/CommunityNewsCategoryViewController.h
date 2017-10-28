//
//  CommunityNewsViewController.h
//  zhongying
//
//  Created by lik on 14-4-10.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import "ZhongYingBaseViewController.h"
#import "CommunicationManager.h"
#import "SelectFoldableView.h"
#import "GetNewsCategoryResponseParameter.h"
#import "DownloadCacher.h"
#import "EGORefreshTableHeaderView.h"
#import "PageDataManager.h"

@interface CommunityNewsCategoryViewController : ZhongYingBaseViewController<FoldableViewDataDelegate, FoldableViewDelegate, UITableViewDataSource, UITableViewDelegate, CommunicationDelegate,EGORefreshTableHeaderDelegate>{
    GetNewsCategoryResponseParameter *currentResponse;
    DownloadCacher *cacher;
    
    NSInteger currentSelectIndex;
    EGORefreshTableHeaderView *refreshHeaderView;
    PageDataManager *newsDataManager;
    BOOL isReloading;
}


@property (strong) IBOutlet UITableView *tableInformations;
@property (strong) IBOutlet SelectFoldableView *communitiesView;

@property (strong) IBOutlet UILabel *labelCommunity;
@property (strong) IBOutlet NSLayoutConstraint *tableHeight;

- (IBAction)getMore:(id)sender;

@end

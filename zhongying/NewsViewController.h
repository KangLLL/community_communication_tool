//
//  NewsViewController.h
//  zhongying
//
//  Created by lk on 14-4-22.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import "ZhongYingBaseViewController.h"
#import "CommunicationManager.h"
#import "GetNewsResponseParameter.h"
#import "NewsCategoryParameter.h"
#import "EGORefreshTableHeaderView.h"
#import "PageDataManager.h"

@interface NewsViewController : ZhongYingBaseViewController<UITableViewDataSource, UITableViewDelegate, CommunicationDelegate,EGORefreshTableHeaderDelegate>{
    GetNewsResponseParameter *currentResponse;
    NSInteger currentSelectIndex;
    
    EGORefreshTableHeaderView *refreshHeaderView;
    PageDataManager *newsDataManager;
    BOOL isReloading;
}

@property (strong) IBOutlet UILabel *labelTitle;
@property (strong) IBOutlet UITableView *tableNews;

@property (strong) NewsCategoryParameter *category;

@end

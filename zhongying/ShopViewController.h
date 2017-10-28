//
//  ShopViewController.h
//  zhongying
//
//  Created by lk on 14-4-21.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import "ZhongYingBaseViewController.h"
#import "CommunicationManager.h"
#import "GetShopsResponseParameter.h"
#import "DownloadCacher.h"
#import "RegionInformation.h"
#import "CategoryParameter.h"
#import "EGORefreshTableHeaderView.h"
#import "PageDataManager.h"

typedef enum{
    shopSelectionCategory,
    shopSelectionDistrict,
    shopSelectionCommunity
}shopSelectionType;

@interface ShopViewController : ZhongYingBaseViewController<CommunicationDelegate, UITableViewDataSource, UITableViewDelegate,EGORefreshTableHeaderDelegate>{
    GetShopsResponseParameter *currentResponse;
    UITableView *tableCommunitySelection;
    
    RegionInformation *currentProvince;
    RegionInformation *currentCity;
    RegionInformation *currentDisctrict;
    
    CategoryParameter *currentParentCategory;
    CategoryParameter *currentChildCategory;
    
    shopSelectionType currentType;
    
    DownloadCacher *cacher;
    
    NSInteger currentSelectIndex;
    EGORefreshTableHeaderView *refreshHeaderView;
    PageDataManager *shopDataManager;
    BOOL isReloading;
}

@property (strong) IBOutlet UITableView *tableShops;
@property (strong) IBOutlet UITableView *tableCategoryParent;
@property (strong) IBOutlet UITableView *tableCategoryChild;
@property (strong) IBOutlet UITableView *tableProvince;
@property (strong) IBOutlet UITableView *tableCity;
@property (strong) IBOutlet UITableView *tableDistrict;

@property (strong) IBOutlet UIButton *buttonCategory;
@property (strong) IBOutlet UIButton *buttonDistrict;

@property (strong) IBOutlet UIView *viewMask;

- (IBAction)selectCategory:(id)sender;
- (IBAction)selectDistrict:(id)sender;
- (IBAction)selectCommunity:(id)sender;

@end

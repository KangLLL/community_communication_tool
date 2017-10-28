//
//  NeighbourViewController.h
//  zhongying
//
//  Created by lik on 14-4-10.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import "ZhongYingBaseViewController.h"
#import "SelectFoldableView.h"
#import "CommunicationDelegate.h"
#import "GetNeighboursResponseParameter.h"
#import "EGORefreshTableHeaderView.h"
#import "PageDataManager.h"

typedef enum{
    neighbourFilterBuild,
    neighbourFilterFloor,
    neighbourFilterRoom
}NeighbourFilterType;

@interface NeighbourViewController : ZhongYingBaseViewController<FoldableViewDataDelegate, FoldableViewDelegate, UITableViewDataSource, UITableViewDelegate, CommunicationDelegate,EGORefreshTableHeaderDelegate>{
    GetNeighboursResponseParameter *currentNeighbours;
    int currentSelectIndex;
    
    NeighbourFilterType currentFilterType;
    NSMutableArray *arrayBuild;
    NSMutableArray *arrayFloor;
    NSMutableArray *arrayRoom;
    UITableView *tableOptions;
    NSString *filterBuildId;
    NSString *filterFloorId;
    NSString *filterRoomId;
    
    EGORefreshTableHeaderView *refreshHeaderView;
    PageDataManager *neighboursDataManager;
    BOOL isReloading;
}

@property (strong) IBOutlet UILabel *labelCommunityName;

@property (strong) IBOutlet UITableView *tableInformations;
@property (strong) IBOutlet SelectFoldableView *communitiesView;

@property (strong) IBOutlet UIView *viewMask;

- (IBAction)getMore:(id)sender;
- (IBAction)sendMessage:(id)sender;

- (IBAction)filterBuild:(id)sender;
- (IBAction)filterFloor:(id)sender;
- (IBAction)filterRoom:(id)sender;

@end

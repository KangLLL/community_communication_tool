//
//  VoteViewController.h
//  zhongying
//
//  Created by lik on 14-4-7.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import "ZhongYingBaseViewController.h"
#import "CommunicationDelegate.h"
#import "SelectFoldableView.h"
#import "GetVoteListResponseParameter.h"
#import "EGORefreshTableHeaderView.h"
#import "PageDataManager.h"

@interface VoteViewController : ZhongYingBaseViewController<FoldableViewDataDelegate, FoldableViewDelegate, UITableViewDataSource, UITableViewDelegate, CommunicationDelegate,EGORefreshTableHeaderDelegate>{
    GetVoteListResponseParameter *currentResponse;
    NSMutableDictionary *votes;
    //NSMutableArray *votes;
    
    UIImage *imageSingleSelect;
    UIImage *imageSingleUnselct;
    UIImage *imageMultiplySelect;
    UIImage *imageMultiplyUnselect;
    
    BOOL isVoting;
    EGORefreshTableHeaderView *refreshHeaderView;
    PageDataManager *voteDataManager;
    BOOL isReloading;
}

@property (strong) IBOutlet UITableView *tableInformations;
@property (strong) IBOutlet SelectFoldableView *communitiesView;
@property (strong) IBOutlet UILabel *labelCommunity;

- (IBAction)getMore:(id)sender;
- (IBAction)vote:(id)sender;

@end

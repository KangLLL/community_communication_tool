//
//  MyCommunitiesViewController.h
//  zhongying
//
//  Created by lik on 14-3-21.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZhongYingBaseViewController.h"
#import "CommunicationDelegate.h"
#import "GetMyCommunitiesResponseParameter.h"

typedef enum{
    communityGet,
    communityDelete
}CommunityFunction;

@interface MyCommunitiesViewController : ZhongYingBaseViewController<CommunicationDelegate,UITableViewDataSource,UITableViewDelegate>{
    GetMyCommunitiesResponseParameter *currentCommunities;
    CommunityFunction currentFunction;
}

@property (strong) IBOutlet UITableView *tableCommunities;

- (IBAction)checkCharge:(id)sender;
- (IBAction)showCommunityDetailInfo:(id)sender;
- (IBAction)unbind:(id)sender;
- (IBAction)bind:(id)sender;

@end

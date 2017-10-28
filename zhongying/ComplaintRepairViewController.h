//
//  ComplaintRepairViewController.h
//  zhongying
//
//  Created by lik on 14-4-3.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import "ZhongYingBaseViewController.h"
#import "CommunicationDelegate.h"
#import "GetComplaintResponseParameter.h"
#import "GetRepairResponseParameter.h"
#import "SelectFoldableView.h"
#import "EGORefreshTableHeaderView.h"
#import "PageDataManager.h"

typedef enum{
    complaintComplaint,
    complaintRepair
}ComplaintFunction;

@interface ComplaintRepairViewController : ZhongYingBaseViewController<FoldableViewDataDelegate, FoldableViewDelegate, UITableViewDataSource, UITableViewDelegate, CommunicationDelegate, UIAlertViewDelegate,EGORefreshTableHeaderDelegate>{
    GetComplaintResponseParameter *currentComplaintResponse;
    GetRepairResponseParameter *currentRepairResponse;
    
    NSInteger currentSelectIndex;
    EGORefreshTableHeaderView *refreshHeaderView;
    PageDataManager *complaintDataManager;
    PageDataManager *repairDataManager;
    BOOL isReloading;
}

@property (assign) ComplaintFunction currentFunction;

@property (strong) IBOutlet UIButton *buttonComplaint;
@property (strong) IBOutlet UIButton *buttonRepair;

@property (strong) IBOutlet UITableView *tableInformations;
@property (strong) IBOutlet SelectFoldableView *communitiesView;

@property (strong) IBOutlet UILabel *labelComplaintTips;
@property (strong) IBOutlet UILabel *labelRepairTips;

@property (strong) IBOutlet UIView *viewComplaintHead;
@property (strong) IBOutlet UIView *viewRepairHead;

@property (strong) IBOutlet UIButton *buttonAdd;

- (IBAction)getMore:(id)sender;

- (IBAction)getComplaint:(id)sender;
- (IBAction)getRepair:(id)sender;
- (IBAction)deleteComplaint:(id)sender;
- (IBAction)deleteRepair:(id)sender;
- (IBAction)touchAdd:(id)sender;

//- (IBAction)getUtilitiesDetail:(id)sender;
//- (IBAction)getParkingDetail:(id)sender;

@end

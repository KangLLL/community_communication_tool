//
//  ComplaintRepairViewController.h
//  zhongying
//
//  Created by lik on 14-3-23.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import "ZhongYingBaseViewController.h"
#import "CommunicationDelegate.h"
#import "GetComplaintResponseParameter.h"
#import "GetRepairResponseParameter.h"
#import "MyCommunityParameter.h"

typedef enum{
    complaintComplaint,
    complaintRepair
}ComplaintRepairFunction;

@interface ComplaintRepairViewController1 : ZhongYingBaseViewController<CommunicationDelegate,UITableViewDataSource,UITableViewDelegate>{
    GetComplaintResponseParameter *currentComplaintResponse;
    GetRepairResponseParameter *currentRepairResponse;
    MyCommunityParameter *currentCommunity;
}

@property (strong) IBOutlet UIButton *buttonComplaint;
@property (strong) IBOutlet UIButton *buttonRepair;
@property (strong) IBOutlet UITableView *tableInformations;
@property (strong) IBOutlet UILabel *labelTitle;

@property (assign) ComplaintRepairFunction currentFunction;

- (IBAction)getComplaint:(id)sender;
- (IBAction)getRepair:(id)sender;
@end

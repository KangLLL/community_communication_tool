//
//  ComplaintRepairViewController.m
//  zhongying
//
//  Created by lik on 14-3-23.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import "ComplaintRepairViewController1.h"
#import "GetComplaintRequestParameter.h"
#import "GetRepairRequestParameter.h"
#import "ComplaintParameter.h"
#import "RepairParameter.h"
#import "ComplaintCell.h"
#import "RepairCell.h"
#import "UserInformation.h"
#import "CommunicationManager.h"
#import "CommonUtilities.h"
#import "CommonEnum.h"

#define COMPLAINT_HEAD_REUSE_IDENTIFIER         @"ComplaintHead"
#define COMPLAINT_CONTENT_REUSE_IDENTIFIER      @"ComplaintContent"
#define REPAIR_HEAD_REUSE_IDENTIFIER            @"RepairHead"
#define REPAIR_CONTENT_REUSE_IDENTIFIER         @"RepairContent"
#define COMPLAINT_TITLE_FORMAT                  @"历史用户投诉情况（%@）"
#define REPAIR_TITLE_FORMAT                     @"历史故障处理情况（%@）"
#define HANDLE_MESSAGE                          @"已处理"
#define NOT_HANDLE_MESSAGE                      @"未处理"

@interface ComplaintRepairViewController1 ()

- (void)sendGetComplaintRequest;
- (void)sendGetRepairRequest;

@end

@implementation ComplaintRepairViewController1

@synthesize buttonComplaint, buttonRepair, tableInformations,labelTitle, currentFunction;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //currentCommunity = [[UserInformation instance].communities objectAtIndex:[UserInformation instance].currentCommunityIndex];
    self.tableInformations.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    switch (self.currentFunction) {
        case complaintComplaint:
            [self sendGetComplaintRequest];
            break;
        case complaintRepair:
            [self sendGetRepairRequest];
            break;
    }
}


#pragma mark - Private Methods
- (void)sendGetComplaintRequest
{
    //[self.buttonUtilities setHighlighted:YES];
    //[self.butonParking setHighlighted:NO];
    //[self.buttonExpress setHighlighted:NO];
    
    self.labelTitle.text = [NSString stringWithFormat:COMPLAINT_TITLE_FORMAT, currentCommunity.communityName];
    
    [self.tableInformations reloadData];
    currentComplaintResponse = nil;
    
    GetComplaintRequestParameter *request = [[GetComplaintRequestParameter alloc] init];
    request.communityId = currentCommunity.communityId;
    request.userId = [UserInformation instance].userId;
    request.password = [UserInformation instance].password;
    
    [[CommunicationManager instance] getComplaint:request withDelegate:self];
    [[CommonUtilities instance] showNetworkConnecting:self];
}

- (void)sendGetRepairRequest
{
    //[self.buttonUtilities setHighlighted:NO];
    //[self.butonParking setHighlighted:YES];
    //[self.buttonExpress setHighlighted:NO];
    
    self.labelTitle.text = [NSString stringWithFormat:REPAIR_TITLE_FORMAT, currentCommunity.communityName];
    
    [self.tableInformations reloadData];
    currentRepairResponse = nil;
    
    GetRepairRequestParameter *request = [[GetRepairRequestParameter alloc] init];
    request.communityId = currentCommunity.communityId;
    request.userId = [UserInformation instance].userId;
    request.password = [UserInformation instance].password;
    
    [[CommunicationManager instance] getRepair:request withDelegate:self];
    [[CommonUtilities instance] showNetworkConnecting:self];
}

#pragma mark - Data table Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (self.currentFunction) {
        case complaintComplaint:
            if(currentComplaintResponse == nil){
                return 1;
            }
            else{
                return [currentComplaintResponse.complaints count] + 1;
            }
        case complaintRepair:
            if(currentRepairResponse == nil){
                return 1;
            }
            else{
                return [currentRepairResponse.repairs count] + 1;
            }
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (self.currentFunction) {
        case complaintComplaint:{
            if(indexPath.row == 0){
                UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:COMPLAINT_HEAD_REUSE_IDENTIFIER forIndexPath:indexPath];
                return cell;
            }
            else{
                ComplaintCell *cell = [tableView dequeueReusableCellWithIdentifier:COMPLAINT_CONTENT_REUSE_IDENTIFIER forIndexPath:indexPath];
                ComplaintParameter *complaint = [currentComplaintResponse.complaints objectAtIndex:indexPath.row - 1];
                cell.labelTime.text = complaint.time;
                cell.labelTitle.text = complaint.title;
                //cell.labelStatus.text = complaint.responseType == ComplaintHandled ? HANDLE_MESSAGE : NOT_HANDLE_MESSAGE;
                return cell;
            }
        }
            break;
        case complaintRepair:{
            if(indexPath.row == 0){
                UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:REPAIR_HEAD_REUSE_IDENTIFIER forIndexPath:indexPath];
                return cell;
            }
            else{
                RepairCell *cell = [tableView dequeueReusableCellWithIdentifier:REPAIR_CONTENT_REUSE_IDENTIFIER forIndexPath:indexPath];
                RepairParameter *repair =[currentRepairResponse.repairs objectAtIndex:indexPath.row - 1];
                cell.labelTime.text = repair.time;
                cell.labelTitle.text = repair.title;
                //cell.labelStatus.text = repair.responseType == RepairHandled ? HANDLE_MESSAGE : NOT_HANDLE_MESSAGE;
                return cell;
            }
        }
            break;
    }
}

#pragma mark - Button Actions

- (IBAction)getComplaint:(id)sender
{
    currentFunction = complaintComplaint;
    [self sendGetComplaintRequest];
}

- (IBAction)getRepair:(id)sender
{
    currentFunction = complaintRepair;
    [self sendGetRepairRequest];
}

#pragma mark - Communication Delegate

- (void)ProcessServerResponse:(id)response
{
    switch (self.currentFunction) {
        case complaintComplaint:
            currentComplaintResponse = response;
            break;
        case complaintRepair:
            currentRepairResponse = response;
            break;
    }
    
    [self.tableInformations reloadData];
    [[CommonUtilities instance] hideNetworkConnecting];
}

- (void)ProcessServerFail:(ServerFailInformation *)failInfo
{
    [[CommonUtilities instance] hideNetworkConnecting];
    NSLog(@"%@",failInfo.message);
}

- (void)ProcessCommunicationError:(NSError *)error
{
    [[CommonUtilities instance] hideNetworkConnecting];
    NSLog(@"%@",error.localizedDescription);
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

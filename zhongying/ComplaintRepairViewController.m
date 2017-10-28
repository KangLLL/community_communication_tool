//
//  ComplaintRepairViewController.m
//  zhongying
//
//  Created by lik on 14-4-3.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import "ComplaintRepairViewController.h"
#import "GetComplaintRequestParameter.h"
#import "GetRepairRequestParameter.h"
#import "UserInformation.h"
#import "CommonUtilities.h"
#import "CommonConsts.h"
#import "CommonHelper.h"
#import "CommunicationManager.h"
#import "ComplaintComplaintCell.h"
#import "ComplaintRepairCell.h"
#import "ComplaintParameter.h"
#import "RepairParameter.h"
#import "DeleteComplaintRequestParameter.h"
#import "DeleteRepairRequestParameter.h"
#import "ComplaintRepairDetailViewController.h"
#import "AddComplaintRepairViewController.h"

#define COMPLAINT_HEAD_REUSE_IDENTIFIER         @"ComplaintHead"
#define COMPLAINT_CONTENT_REUSE_IDENTIFIER      @"ComplaintContent"
#define REPAIR_HEAD_REUSE_IDENTIFIER            @"RepairHead"
#define REPAIR_CONTENT_REUSE_IDENTIFIER         @"RepairContent"

#define COMMUNITY_BUTTON_TITLE_FORMAT           @"%@(%@)"

#define ADD_REPAIR_SEGUE_IDENTIFIER             @"AddRepair"
#define ADD_COMPLAINT_SEGUE_IDENTIFIER          @"AddComplaint"
#define DETAIL_SEGUE_IDENTIFIER                 @"Detail"

#define ADD_COMPLAINT_BUTTON_TEXT               @"添加投诉"
#define ADD_REPAIR_BUTTON_TEXT                  @"添加申报"

#define COMPLAINT_PAGE_SIZE                     15

@interface ComplaintRepairViewController ()

- (void)sendGetComplaintRequest;
- (void)sendGetRepairRequest;
- (void)sendDeleteComplaintRequest;
- (void)sendDeleteRepairRequest;
- (void)sendUpdateCommunityRequest;
- (void)displayController;

- (void)sendGetComplaintRequestWithPage:(int)page andPageSize:(int)pageSize;
- (void)sendGetRepairRequestWithPage:(int)page andPageSize:(int)pageSize;

@end

@implementation ComplaintRepairViewController

@synthesize currentFunction, buttonComplaint, buttonRepair, tableInformations, communitiesView, labelComplaintTips, labelRepairTips, buttonAdd;

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
    self.tableInformations.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.communitiesView.selectItemImage = [UIImage imageNamed:COMMUNITY_DEFAULT_SELECT_IMAGE_NAME];
    self.communitiesView.unselectItemImage = [UIImage imageNamed:COMMUNITY_DEFAULT_UNSELECT_IMAGE_NAME];
    
    [self.communitiesView reloadData];
    [self.communitiesView setSelectIndex:[UserInformation instance].currentCommunityIndex];
    
    switch (self.currentFunction) {
        case complaintComplaint:
            [self.buttonComplaint setSelected:YES];
            [self.buttonAdd setTitle:ADD_COMPLAINT_BUTTON_TEXT forState:UIControlStateNormal];
            break;
        case complaintRepair:
            [self.buttonRepair setSelected:YES];
            [self.buttonAdd setTitle:ADD_REPAIR_BUTTON_TEXT forState:UIControlStateNormal];
            break;
    }
    [self displayController];
    
    complaintDataManager = [[PageDataManager alloc] initWithPageSize:COMPLAINT_PAGE_SIZE];
    repairDataManager = [[PageDataManager alloc] initWithPageSize:COMPLAINT_PAGE_SIZE];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated
{
    [self sendUpdateCommunityRequest];
}

#pragma mark - Button Actions

- (IBAction)getComplaint:(id)sender
{
    if(self.currentFunction != complaintComplaint){
        self.currentFunction = complaintComplaint;
        [self.buttonComplaint setSelected:YES];
        [self.buttonRepair setSelected:NO];
        
        [self displayController];
        [self.communitiesView reloadData];
        [self.communitiesView setSelectIndex:[UserInformation instance].currentCommunityIndex];
        [complaintDataManager clear];
        [self sendGetComplaintRequest];
        [self.buttonAdd setTitle:ADD_COMPLAINT_BUTTON_TEXT forState:UIControlStateNormal];
    }
}

- (IBAction)getRepair:(id)sender
{
    if(self.currentFunction != complaintRepair){
        self.currentFunction = complaintRepair;
        [self.buttonComplaint setSelected:NO];
        [self.buttonRepair setSelected:YES];
        
        [self displayController];
        [self.communitiesView reloadData];
        [self.communitiesView setSelectIndex:[UserInformation instance].currentCommunityIndex];
        [repairDataManager clear];
        [self sendGetRepairRequest];
        [self.buttonAdd setTitle:ADD_REPAIR_BUTTON_TEXT forState:UIControlStateNormal];
    }
}

- (IBAction)getMore:(id)sender
{
    UIButton *button = (UIButton *)sender;
    if(self.communitiesView.isFolded){
        [self.communitiesView unfoldView];
        [button setTitle:GET_MORE_COMMUNITY_BUTTON_UNFOLD_TITLE forState:UIControlStateNormal];
        [button setSelected:YES];
    }
    else{
        [self.communitiesView foldView];
        [button setTitle:GET_MORE_COMMUNITY_BUTTON_FOLD_TITLE forState:UIControlStateNormal];
        [button setSelected:NO];
    }
}

- (IBAction)touchAdd:(id)sender
{
    switch (currentFunction) {
        case complaintComplaint:
            [self performSegueWithIdentifier:ADD_REPAIR_SEGUE_IDENTIFIER sender:nil];
            break;
        case complaintRepair:
            [self performSegueWithIdentifier:ADD_REPAIR_SEGUE_IDENTIFIER sender:nil];
            break;
        }
}

#pragma mark - Cell Button Actions

- (IBAction)deleteComplaint:(id)sender
{
    UIButton *button = (UIButton *)sender;
    currentSelectIndex = [self.tableInformations indexPathForCell:[CommonHelper getParentCell:button]].row;
    
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示"
                                                   message:@"确定要删除申报吗？"
                                                  delegate:self
                                         cancelButtonTitle:@"取消"
                                         otherButtonTitles:@"确定",nil];
    
    [alert show];
}

- (IBAction)deleteRepair:(id)sender
{
    UIButton *button = (UIButton *)sender;
    currentSelectIndex = [self.tableInformations indexPathForCell:[CommonHelper getParentCell:button]].row;
    
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示"
                                                   message:@"确定要删除申报吗？"
                                                  delegate:self
                                         cancelButtonTitle:@"取消"
                                         otherButtonTitles:@"确定",nil];
    
    [alert show];
}

#pragma mark - Private Methods

- (void)sendGetComplaintRequest
{
    [self sendGetComplaintRequestWithPage:[complaintDataManager getNextLoadPage] andPageSize:COMPLAINT_PAGE_SIZE];
}

- (void)sendGetRepairRequest
{
    [self sendGetRepairRequestWithPage:[repairDataManager getNextLoadPage] andPageSize:COMPLAINT_PAGE_SIZE];
}

- (void)sendGetComplaintRequestWithPage:(int)page andPageSize:(int)pageSize
{
    currentComplaintResponse = nil;
    
    GetComplaintRequestParameter *request = [[GetComplaintRequestParameter alloc] init];
    request.communityId = [UserInformation instance].currentCommunity.communityId;
    request.userId = [UserInformation instance].userId;
    request.password = [UserInformation instance].password;
    request.page = page;
    request.pageSize = pageSize;
    
    [[CommunicationManager instance] getComplaint:request withDelegate:self];
    [[CommonUtilities instance] showNetworkConnecting:self];
}

- (void)sendGetRepairRequestWithPage:(int)page andPageSize:(int)pageSize
{
    currentRepairResponse = nil;
    
    GetRepairRequestParameter *request = [[GetRepairRequestParameter alloc] init];
    request.communityId = [UserInformation instance].currentCommunity.communityId;
    request.userId = [UserInformation instance].userId;
    request.password = [UserInformation instance].password;
    request.page = page;
    request.pageSize = pageSize;
    
    [[CommunicationManager instance] getRepair:request withDelegate:self];
    [[CommonUtilities instance] showNetworkConnecting:self];
}

- (void)sendDeleteComplaintRequest
{
    DeleteComplaintRequestParameter *request = [[DeleteComplaintRequestParameter alloc] init];
    ComplaintParameter *param = [[complaintDataManager allData] objectAtIndex:currentSelectIndex];
    request.messageId = param.messageId;
    request.userId = [UserInformation instance].userId;
    request.password = [UserInformation instance].password;
    
    [[CommunicationManager instance] deleteComplaint:request withDelegate:self];
    [[CommonUtilities instance] showNetworkConnecting:self];
}

- (void)sendDeleteRepairRequest
{
    DeleteRepairRequestParameter *request = [[DeleteRepairRequestParameter alloc] init];
    RepairParameter *param = [[repairDataManager allData] objectAtIndex:currentSelectIndex];
    request.messageId = param.messageId;
    request.userId = [UserInformation instance].userId;
    request.password = [UserInformation instance].password;
    
    [[CommunicationManager instance] deleteRepair:request withDelegate:self];
    [[CommonUtilities instance] showNetworkConnecting:self];
}

- (void)sendUpdateCommunityRequest
{
    GetMyCommunitiesRequestParameter *request = [[GetMyCommunitiesRequestParameter alloc] init];
    request.userId = [UserInformation instance].userId;
    request.password = [UserInformation instance].password;
    request.isUserCenter = YES;
    [[CommunicationManager instance] getMyCommunities:request withDelegate:self];
    [[CommonUtilities instance] showNetworkConnecting:self];
}

- (void)displayController
{
    switch (currentFunction) {
        case complaintComplaint:
            self.labelRepairTips.hidden = YES;
            self.labelComplaintTips.hidden = NO;
            self.viewRepairHead.hidden = YES;
            self.viewComplaintHead.hidden = NO;
            break;
        case complaintRepair:
            self.labelRepairTips.hidden = NO;
            self.labelComplaintTips.hidden = YES;
            self.viewRepairHead.hidden = NO;
            self.viewComplaintHead.hidden = YES;
            break;
    }
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
            return [[complaintDataManager allData] count];
        case complaintRepair:
            return [[repairDataManager allData] count];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 35;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (self.currentFunction) {
        case complaintComplaint: {
            ComplaintComplaintCell *cell = [tableView dequeueReusableCellWithIdentifier:COMPLAINT_CONTENT_REUSE_IDENTIFIER forIndexPath:indexPath];
            ComplaintParameter *param = [[complaintDataManager allData] objectAtIndex:indexPath.row];
            cell.labelTime.text = param.time;
            cell.labelTitle.text = param.title;
            
            cell.buttonOperation.userInteractionEnabled = NO;
            if(param.responseType == messageConfirm){
                [cell.buttonOperation setTitle:@"正在核实" forState:UIControlStateNormal];
            }
            else if(param.responseType == messageProcess){
                [cell.buttonOperation setTitle:@"已安排" forState:UIControlStateNormal];
            }
            else if(param.responseType == messageComplete){
                [cell.buttonOperation setTitle:@"已完成" forState:UIControlStateNormal];
            }
            else{
                [cell.buttonOperation setTitle:@"[删除申报]" forState:UIControlStateNormal];
                cell.buttonOperation.userInteractionEnabled = YES;
            }
            
            return cell;
        }
        case complaintRepair:{
            ComplaintRepairCell *cell = [tableView dequeueReusableCellWithIdentifier:REPAIR_CONTENT_REUSE_IDENTIFIER forIndexPath:indexPath];
            RepairParameter *param = [[repairDataManager allData] objectAtIndex:indexPath.row];
            cell.labelTime.text = param.time;
            cell.labelTitle.text = param.title;
            
            cell.buttonOperation.userInteractionEnabled = NO;
            if(param.responseType == messageConfirm){
                [cell.buttonOperation setTitle:@"正在核实" forState:UIControlStateNormal];
            }
            else if(param.responseType == messageProcess){
                [cell.buttonOperation setTitle:@"已安排" forState:UIControlStateNormal];
            }
            else if(param.responseType == messageComplete){
                [cell.buttonOperation setTitle:@"已完成" forState:UIControlStateNormal];
            }
            else{
                [cell.buttonOperation setTitle:@"[删除申报]" forState:UIControlStateNormal];
                cell.buttonOperation.userInteractionEnabled = YES;
            }
            
            return cell;
        }
    }
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    currentSelectIndex = indexPath.row;
    [self performSegueWithIdentifier:DETAIL_SEGUE_IDENTIFIER sender:nil];
}

#pragma mark - FoldableView Delegate

- (int)numberOfItemInView
{
    return [[UserInformation instance].communities count];
}

- (NSString *)foldableView:(FoldableView *)foldableView titleAtIndex:(int)index
{
    CommunityInformation *comm = [[UserInformation instance] getCommunity:index];
    NSString *numberInformation = currentFunction == complaintComplaint ? comm.complaintNumber : comm.repairNumber;
    return [NSString stringWithFormat:COMMUNITY_BUTTON_TITLE_FORMAT,comm.communityName, numberInformation];
    
    //return [NSString stringWithFormat:@"小区%d",index];
}

- (void)foldableView:(FoldableView *)foldableView didSelectAtIndex:(int)index
{
    [UserInformation instance].currentCommunityIndex = index;
    
    switch (self.currentFunction) {
        case complaintComplaint:
            [complaintDataManager clear];
            [self sendGetComplaintRequest];
            break;
        case complaintRepair:
            [repairDataManager clear];
            [self sendGetRepairRequest];
            break;
    }
}

#pragma mark - Communication Delegate

- (void)ProcessServerResponse:(id)response
{
    if([response isKindOfClass:[GetMyCommunitiesResponseParameter class]]){
        [[UserInformation instance] initialCommunities:response];
        [self.communitiesView reloadData];
        [self.communitiesView setSelectIndex:[UserInformation instance].currentCommunityIndex];
        switch (self.currentFunction) {
            case complaintComplaint:
                if([[complaintDataManager allData] count] == 0){
                    [self sendGetComplaintRequest];
                }
                else{
                    [self sendGetComplaintRequestWithPage:1 andPageSize:[[complaintDataManager allData] count]];
                    [complaintDataManager clear];
                }
                break;
            case complaintRepair:
                if([[repairDataManager allData] count] == 0){
                    [self sendGetRepairRequest];
                }
                else{
                    [self sendGetRepairRequestWithPage:1 andPageSize:[[repairDataManager allData] count]];
                    [repairDataManager clear];
                }
                break;
        }
    }
    else if([response isKindOfClass:[GetComplaintResponseParameter class]] || [response isKindOfClass:[GetRepairResponseParameter class]]){
        switch (self.currentFunction) {
            case complaintComplaint:
                currentComplaintResponse = response;
                [complaintDataManager populateData:currentComplaintResponse.complaints];
                break;
            case complaintRepair:
                currentRepairResponse = response;
                [repairDataManager populateData:currentRepairResponse.repairs];
                break;
        }
        [self.tableInformations reloadData];
        CGFloat height = MAX(self.tableInformations.contentSize.height, self.tableInformations.frame.size.height);
        if(refreshHeaderView == nil){
            EGORefreshTableHeaderView *view =[[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0.0f, height, self.tableInformations.bounds.size.width, self.tableInformations.bounds.size.height)];
            view.delegate = self;
            [self.tableInformations addSubview:view];
            refreshHeaderView = view;
        }
        else{
            CGRect newFrame = refreshHeaderView.frame;
            newFrame.origin.y = height;
            refreshHeaderView.frame = newFrame;
            [refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:self.tableInformations];
            isReloading = NO;
        }
        
        [[CommonUtilities instance] hideNetworkConnecting];
    }
    else{
        [self showErrorMessage:@"删除成功"];
        [self sendUpdateCommunityRequest];
    }
}

- (void)ProcessServerFail:(ServerFailInformation *)failInfo
{
    [[CommonUtilities instance] hideNetworkConnecting];
    [self.tableInformations reloadData];
    [refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:self.tableInformations];
    isReloading = NO;
    NSLog(@"%@",failInfo.message);
    [self showErrorMessage:failInfo.message];
}

- (void)ProcessCommunicationError:(NSError *)error
{
    [[CommonUtilities instance] hideNetworkConnecting];
    [refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:self.tableInformations];
    isReloading = NO;
    NSLog(@"%@",error.localizedDescription);
    [self showErrorMessage:error.localizedDescription];
}

#pragma mark - Alert View Delegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex > 0){
        if(currentFunction == complaintComplaint){
            [self sendDeleteComplaintRequest];
        }
        else{
            [self sendDeleteRepairRequest];
        }
    }
}

#pragma mark - EGORefreshTableHeaderDelegate Methods
-(void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView*)view{
    isReloading = YES;
    switch (currentFunction) {
        case complaintComplaint:
            [self sendGetComplaintRequest];
            break;
        case complaintRepair:
            [self sendGetRepairRequest];
            break;
    }
}

-(BOOL)egoRefreshTableHeaderDataSourceIsLoading:(EGORefreshTableHeaderView*)view{
    return isReloading;
}

#pragma mark - UIScrollViewDelegate Methods

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [refreshHeaderView egoRefreshScrollViewDidScroll:scrollView];
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    [refreshHeaderView egoRefreshScrollViewDidEndDragging:scrollView];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.destinationViewController isKindOfClass:[ComplaintRepairDetailViewController class]]){
        ComplaintRepairDetailViewController *controller = (ComplaintRepairDetailViewController *)segue.destinationViewController;
        if(currentFunction == complaintComplaint){
            ComplaintParameter *param = [[complaintDataManager allData] objectAtIndex:currentSelectIndex];
            controller.complaint = param;
        }
        else{
            RepairParameter *param = [[repairDataManager allData] objectAtIndex:currentSelectIndex];
            controller.repair = param;
        }
    }
    if([segue.destinationViewController isKindOfClass:[AddComplaintRepairViewController class]]){
        AddComplaintRepairViewController *controller = (AddComplaintRepairViewController *)segue.destinationViewController;
        controller.isComplaint = currentFunction == complaintComplaint;
    }
}

@end

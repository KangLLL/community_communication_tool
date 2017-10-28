//
//  GroupViewController.m
//  zhongying
//
//  Created by LI K on 12/4/14.
//  Copyright (c) 2014 lik. All rights reserved.
//

#import "GroupViewController.h"
#import "UserInformation.h"
#import "CommonUtilities.h"
#import "CommonConsts.h"
#import "CommunicationManager.h"
#import "GroupCell.h"
#import "GroupParameter.h"
#import "GetGroupsRequestParameter.h"
#import "GetReservesRequestParameter.h"
#import "GroupDetailViewController.h"

#define GROUP_CELL_REUSE_IDENTIFIER         @"Group"
#define MAX_RESTRICT_FORMAT                 @"每人限购%d件"
#define DETAIL_SEGUE_IDENTIFIER             @"Detail"

@interface GroupViewController ()

- (void)sendGetGroupsRequest;
- (void)sendGetReservesRequest;

- (void)sendGetGroupsRequestWithPage:(int)page andPageSize:(int)pageSize;
- (void)sendGetReservesRequestWithPage:(int)page andPageSize:(int)pageSize;

@end

@implementation GroupViewController

@synthesize tableInformations, isGroup, labelTitle;

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
    cacher = [[DownloadCacher alloc] init];
    self.labelTitle.text = isGroup ? @"特惠" : @"预定";
    dataManager = [[PageDataManager alloc] initWithPageSize:DEFAULT_PAGE_SIZE];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated
{
    if(self.isGroup){
        if([[dataManager allData] count] == 0){
            [self sendGetGroupsRequest];
        }
        else{
            [self sendGetGroupsRequestWithPage:1 andPageSize:[[dataManager allData] count]];
            [dataManager clear];
        }
    }
    else{
        if([[dataManager allData] count] == 0){
            [self sendGetReservesRequest];
        }
        else{
            [self sendGetReservesRequestWithPage:1 andPageSize:[[dataManager allData] count]];
            [dataManager clear];
        }
        [self sendGetReservesRequest];
    }
}


#pragma mark - Private Methods

- (void)sendGetGroupsRequest
{
    [self sendGetGroupsRequestWithPage:[dataManager getNextLoadPage] andPageSize:DEFAULT_PAGE_SIZE];
}

- (void)sendGetReservesRequest
{
    [self sendGetReservesRequestWithPage:[dataManager getNextLoadPage] andPageSize:DEFAULT_PAGE_SIZE];
}

- (void)sendGetGroupsRequestWithPage:(int)page andPageSize:(int)pageSize
{
    currentResponse = nil;
    
    GetGroupsRequestParameter *request = [[GetGroupsRequestParameter alloc] init];
    request.userId = [UserInformation instance].userId;
    request.password = [UserInformation instance].password;
    request.page = page;
    request.pageSize = pageSize;
    
    [[CommunicationManager instance] getGroups:request withDelegate:self];
    [[CommonUtilities instance] showNetworkConnecting:self];
}

- (void)sendGetReservesRequestWithPage:(int)page andPageSize:(int)pageSize
{
    currentResponse = nil;
    
    GetReservesRequestParameter *request = [[GetReservesRequestParameter alloc] init];
    request.userId = [UserInformation instance].userId;
    request.password = [UserInformation instance].password;
    request.page = page;
    request.pageSize = pageSize;
    
    [[CommunicationManager instance] getReserves:request withDelegate:self];
    [[CommonUtilities instance] showNetworkConnecting:self];
}

#pragma mark - Data table Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [[dataManager allData] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 90;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 6;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor clearColor];
    return view;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    int index = indexPath.section;
    GroupParameter *param = [[dataManager allData] objectAtIndex:index];
    GroupCell *cell = [tableView dequeueReusableCellWithIdentifier:GROUP_CELL_REUSE_IDENTIFIER forIndexPath:indexPath];
    
    cell.labelName.text = param.title;
    cell.labelRestrict.text = [NSString stringWithFormat:MAX_RESTRICT_FORMAT, param.maxRestrict];
    
    [cell setOriginalPrice:param.originalPrice andGroupPrice:param.groupPrice forDiscount:param.discount];
    
    cell.tag = index;
    
    [cacher getImageWithUrl:param.imageUrl andCell:cell inImageView:cell.imagePhoto withActivityView:cell.activity];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    currentSelectIndex = indexPath.section;
    [self performSegueWithIdentifier:DETAIL_SEGUE_IDENTIFIER sender:nil];
}

#pragma mark - Communication Delegate

- (void)ProcessServerResponse:(id)response
{
    currentResponse = response;
    
    [dataManager populateData:currentResponse.groups];
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

- (void)ProcessServerFail:(ServerFailInformation *)failInfo
{
    [[CommonUtilities instance] hideNetworkConnecting];
    NSLog(@"%@",failInfo.message);
    [self showErrorMessage:failInfo.message];
}

- (void)ProcessCommunicationError:(NSError *)error
{
    [[CommonUtilities instance] hideNetworkConnecting];
    NSLog(@"%@",error.localizedDescription);
    [self showErrorMessage:error.localizedDescription];
}

#pragma mark - EGORefreshTableHeaderDelegate Methods
-(void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView*)view
{
    isReloading = YES;
    if (self.isGroup) {
        [self sendGetGroupsRequest];
    }
    else{
        [self sendGetReservesRequest];
    }
}

-(BOOL)egoRefreshTableHeaderDataSourceIsLoading:(EGORefreshTableHeaderView*)view
{
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

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    self.hidesBottomBarWhenPushed = YES;
    GroupDetailViewController *detailController = (GroupDetailViewController *)segue.destinationViewController;
    detailController.groupList = self;
    
    GroupParameter *groupParam = [[dataManager allData] objectAtIndex:currentSelectIndex];
    detailController.groupId = groupParam.groupId;
}

@end

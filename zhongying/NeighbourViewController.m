//
//  NeighbourViewController.m
//  zhongying
//
//  Created by lik on 14-4-10.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import "NeighbourViewController.h"
#import "CommonConsts.h"
#import "CommunicationManager.h"
#import "CommonUtilities.h"
#import "UserInformation.h"
#import "CommonHelper.h"
#import "GetNeighboursRequestParameter.h"
#import "NeighbourParameter.h"
#import "NeighbourCell.h"
#import "OptionCell.h"
#import "NeighbourMessageViewController.h"

#define CONTENT_REUSE_IDENTIFIER        @"Content"

#define MESSAGE_SEGUE_IDENTIFIER        @"Message"
#define PAGE_SIZE                       20

@interface NeighbourViewController ()

- (void)sendGetNeighboursRequest;
- (void)sendGetNeighboursRequestWithPage:(int)page andPageSize:(int)pageSize;

- (void)constructSelectionTable;
- (void)showSelectionTable;
- (void)hideSelectionTable;
- (void)constructBuildOptions;
- (void)constructFloorOptions;
- (void)constructRoomOptions;

@end

@implementation NeighbourViewController

@synthesize labelCommunityName, tableInformations, communitiesView;

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
    self.labelCommunityName.text = [[UserInformation instance] currentCommunity].communityName;
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideSelectionTable)];
    [self.viewMask addGestureRecognizer:tapGesture];
    
    neighboursDataManager = [[PageDataManager alloc] initWithPageSize:PAGE_SIZE];
    // Do any additional setup after loading the view.
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated
{
    if([[neighboursDataManager allData] count] == 0){
        [self sendGetNeighboursRequest];
    }
    else{
        [self sendGetNeighboursRequestWithPage:1 andPageSize:[[neighboursDataManager allData] count]];
        [neighboursDataManager clear];
    }
}

#pragma mark - Button Actions

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

- (IBAction)sendMessage:(id)sender
{
    UIButton *button = (UIButton *)sender;
    currentSelectIndex = [self.tableInformations indexPathForCell:[CommonHelper getParentCell:button]].row;
    [self performSegueWithIdentifier:MESSAGE_SEGUE_IDENTIFIER sender:nil];
}

- (void)filterBuild:(id)sender
{
    currentFilterType = neighbourFilterBuild;
    [self showSelectionTable];
}

- (void)filterFloor:(id)sender
{
    if(filterBuildId == nil){
        [self showErrorMessage:@"请先选择一个幢"];
    }
    else{
        currentFilterType = neighbourFilterFloor;
        [self showSelectionTable];
    }
}

- (void)filterRoom:(id)sender
{
    if(filterFloorId == nil){
        [self showErrorMessage:@"请先选择一个层"];
    }
    else{
        currentFilterType = neighbourFilterRoom;
        [self showSelectionTable];
    }
}

#pragma mark - Private Methods

- (void)sendGetNeighboursRequest
{
    [self sendGetNeighboursRequestWithPage:[neighboursDataManager getNextLoadPage] andPageSize:PAGE_SIZE];
}

- (void)sendGetNeighboursRequestWithPage:(int)page andPageSize:(int)pageSize
{
    currentNeighbours = nil;
    
    GetNeighboursRequestParameter *request = [[GetNeighboursRequestParameter alloc] init];
    request.communityId = [UserInformation instance].currentCommunity.communityId;
    request.userId = [UserInformation instance].userId;
    request.password = [UserInformation instance].password;
    request.buildNo = filterBuildId;
    request.floorNo = filterFloorId;
    request.roomNo = filterRoomId;
    request.page = page;
    request.pageSize = pageSize;
    
    [[CommunicationManager instance] getNeighbours:request withDelegate:self];
    [[CommonUtilities instance] showNetworkConnecting:self];
}

- (void)constructSelectionTable
{
    tableOptions = [[UITableView alloc] initWithFrame:CGRectMake(10, 0, 300, 0)];
    [tableOptions registerClass:[OptionCell class] forCellReuseIdentifier:OPTION_CELL_REUSE_IDENTIFIER];
    tableOptions.dataSource = self;
    tableOptions.delegate = self;
    tableOptions.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:tableOptions];
}

- (void)showSelectionTable
{
    if(tableOptions == nil){
        [self constructSelectionTable];
    }
    self.viewMask.hidden = NO;
    tableOptions.hidden = NO;
    
    [tableOptions reloadData];
    float totalHeight = tableOptions.contentSize.height;
    float maxHeight = self.view.bounds.size.height - 2 * MIN_SELECTION_MARGIN;
    
    CGRect newFrame = tableOptions.frame;
    newFrame.size.height = MIN(totalHeight, maxHeight);
    tableOptions.frame = newFrame;
    tableOptions.center = self.view.center;
}

- (void)hideSelectionTable
{
    tableOptions.hidden = YES;
    self.viewMask.hidden = YES;
}

- (void)constructBuildOptions
{
    arrayBuild = [NSMutableArray array];
    for (NeighbourParameter *param in [neighboursDataManager allData]) {
        if(![arrayBuild containsObject:param.buildNo]){
            [arrayBuild addObject:param.buildNo];
        }
    }
}

- (void)constructFloorOptions
{
    arrayFloor = [NSMutableArray array];
    for (NeighbourParameter *param in [neighboursDataManager allData]) {
        if(![arrayFloor containsObject:param.floorNo]){
            [arrayFloor addObject:param.floorNo];
        }
    }
}

- (void)constructRoomOptions
{
    arrayRoom = [NSMutableArray array];
    for (NeighbourParameter *param in [neighboursDataManager allData]) {
        if(![arrayRoom containsObject:param.roomNo]){
            [arrayRoom addObject:param.roomNo];
        }
    }
}

#pragma mark - Data Table Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(tableView == tableOptions){
        switch (currentFilterType) {
            case neighbourFilterBuild:
                return [arrayBuild count];
            case neighbourFilterFloor:
                return [arrayFloor count];
            case neighbourFilterRoom:
                return [arrayRoom count];
        }
    }
    else{
        return [[neighboursDataManager allData] count];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView == tableOptions){
        OptionCell *cell = [tableView dequeueReusableCellWithIdentifier:OPTION_CELL_REUSE_IDENTIFIER forIndexPath:indexPath];
        int index = indexPath.row;
        switch (currentFilterType) {
            case neighbourFilterBuild:{
                [cell setOptionString:[arrayBuild objectAtIndex:index]];
                return cell;
            }
            case neighbourFilterFloor:{
                [cell setOptionString:[arrayFloor objectAtIndex:index]];
                return cell;
            }
            case neighbourFilterRoom:{
                [cell setOptionString:[arrayRoom objectAtIndex:index]];
                return cell;
            }
        }
    }
    else{
        NeighbourParameter *param = [[neighboursDataManager allData] objectAtIndex:indexPath.row];
        NeighbourCell *cell = [tableView dequeueReusableCellWithIdentifier:CONTENT_REUSE_IDENTIFIER forIndexPath:indexPath];
        
        cell.labelBuildNo.text = param.buildNo;
        cell.labelFloorNo.text = param.floorNo;
        cell.labelRoomNo.text = param.roomNo;
        cell.labelName.text = param.name;
        cell.labelMessageCount.text = [param.messageCount isEqualToString:@"0"] ? @"" : [NSString stringWithFormat:@"(%@)",param.messageCount];
        return cell;
    }
}

- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath
{
    return tableView == tableOptions;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView == tableOptions){
        int index = indexPath.row;
        switch (currentFilterType) {
            case neighbourFilterBuild:{
                filterBuildId = [arrayBuild objectAtIndex:index];
                filterFloorId = nil;
                filterRoomId = nil;
                break;
            }
            case neighbourFilterFloor:{
                filterFloorId = [arrayFloor objectAtIndex:index];
                filterRoomId = nil;
                break;
            }
            case neighbourFilterRoom:{
                filterRoomId = [arrayRoom objectAtIndex:index];
                break;
            }
        }
        [self hideSelectionTable];
        [neighboursDataManager clear];
        [self sendGetNeighboursRequest];
    }
}

#pragma mark - Foldable View Delegate

- (int)numberOfItemInView
{
    return [[UserInformation instance].communities count];
}

- (NSString *)foldableView:(FoldableView *)foldableView titleAtIndex:(int)index
{
    CommunityInformation *comm = [[UserInformation instance] getCommunity:index];
    return [NSString stringWithFormat:@"%@(%@)", comm.communityName, comm.neighbourNumber];
}

- (void)foldableView:(FoldableView *)foldableView didSelectAtIndex:(int)index
{
    [UserInformation instance].currentCommunityIndex = index;
    self.labelCommunityName.text = [[UserInformation instance] currentCommunity].communityName;
    filterBuildId = nil;
    filterFloorId = nil;
    filterRoomId = nil;
    [neighboursDataManager clear];
    [self sendGetNeighboursRequest];
}

#pragma mark - Communication Delegate

- (void)ProcessServerResponse:(id)response
{
    currentNeighbours = response;
    [neighboursDataManager populateData:currentNeighbours.neighbours];
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
    if(filterRoomId == nil){
        if(filterFloorId != nil){
            [self constructRoomOptions];
        }
        else if(filterBuildId != nil){
            [self constructFloorOptions];
        }
        else{
            [self constructBuildOptions];
        }
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

#pragma mark - EGORefreshTableHeaderDelegate Methods
-(void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView*)view{
    isReloading = YES;
    [self sendGetNeighboursRequest];
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

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NeighbourParameter *selectNeighbour = [[neighboursDataManager allData] objectAtIndex:currentSelectIndex];
    NeighbourMessageViewController *messageController = (NeighbourMessageViewController *)segue.destinationViewController;
    messageController.currentNeighbour = selectNeighbour;
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


@end

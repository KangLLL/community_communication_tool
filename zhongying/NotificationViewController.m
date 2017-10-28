//
//  NotificationViewController.m
//  zhongying
//
//  Created by lik on 14-4-10.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import "NotificationViewController.h"
#import "CommonConsts.h"
#import "CommunicationManager.h"
#import "CommonUtilities.h"
#import "UserInformation.h"
#import "GetNotificationRequestParameter.h"
#import "NotificationParameter.h"
#import "NotificationCell.h"
#import "NotificationDetailViewController.h"

#define NOTIFICATION_CELL_REUSE_IDENTIFIER  @"Notification"
#define DETAIL_SEGUE_IDENTIFIER             @"Detail"

#define COMMUNITY_NAME_FORMAT               @"[%@]"
#define NOTIFICATION_PAGE_SIZE              15

@interface NotificationViewController ()

- (void)sendGetNotificationRequest;
- (void)sendGetNotificationRequestWithPage:(int)page andPageSize:(int)pageSize;

@end

@implementation NotificationViewController

@synthesize labelCommunityName, tableInformations, tableHeight, communitiesView;

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
    self.labelCommunityName.text = [NSString stringWithFormat:COMMUNITY_NAME_FORMAT,[[UserInformation instance] currentCommunity].communityName];
    
    notificationDataManager = [[PageDataManager alloc] initWithPageSize:NOTIFICATION_PAGE_SIZE];
    // Do any additional setup after loading the view.
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated
{
    if([[notificationDataManager allData] count] == 0){
        [self sendGetNotificationRequest];
    }
    else{
        [self sendGetNotificationRequestWithPage:1 andPageSize:[[notificationDataManager allData] count]];
        [notificationDataManager clear];
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

#pragma mark - Private Methods

- (void)sendGetNotificationRequest
{
    [self sendGetNotificationRequestWithPage:[notificationDataManager getNextLoadPage] andPageSize:NOTIFICATION_PAGE_SIZE];
}

- (void)sendGetNotificationRequestWithPage:(int)page andPageSize:(int)pageSize
{
    currentNotifications = nil;
    
    GetNotificationRequestParameter *request = [[GetNotificationRequestParameter alloc] init];
    request.communityId = [UserInformation instance].currentCommunity.communityId;
    request.userId = [UserInformation instance].userId;
    request.password = [UserInformation instance].password;
    request.page = page;
    request.pageSize = pageSize;
    
    [[CommunicationManager instance] getNotification:request withDelegate:self];
    [[CommonUtilities instance] showNetworkConnecting:self];
}

#pragma mark - Data Table Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [[notificationDataManager allData] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

/*
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row == 0){
        return 10;
    }
    else{
        NotificationParameter *param = [currentNotifications.notifications objectAtIndex:indexPath.section];
        return [NotificationContentCell getCellHeightAccordingToContent:param.content];
    }
}
s*/

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
    NotificationParameter *param = [[notificationDataManager allData] objectAtIndex:indexPath.section];
   
    NotificationCell *cell = [tableView dequeueReusableCellWithIdentifier:NOTIFICATION_CELL_REUSE_IDENTIFIER forIndexPath:indexPath];
    
    if(param.status == NotRead){
        cell.labelTitle.textColor = [UIColor redColor];
    }
    else{
        cell.labelTitle.textColor = [UIColor blackColor];
    }
    cell.labelTitle.text = param.title;
    cell.labelTime.text = param.time;
    
    cell.layer.borderWidth = 1;
    cell.layer.borderColor = [UIColor grayColor].CGColor;
    cell.layer.cornerRadius = 1;
    cell.backgroundColor = CELL_BG_COLOR;
    cell.clipsToBounds = YES;
        
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    currentSelectIndex = indexPath.section;
    [self performSegueWithIdentifier:DETAIL_SEGUE_IDENTIFIER sender:nil];
}

#pragma mark - Foldable View Delegate

- (int)numberOfItemInView
{
    return [[UserInformation instance].communities count];
}

- (NSString *)foldableView:(FoldableView *)foldableView titleAtIndex:(int)index
{
    return [[UserInformation instance] getCommunity:index].communityName;
}

- (void)foldableView:(FoldableView *)foldableView didSelectAtIndex:(int)index
{
    [UserInformation instance].currentCommunityIndex = index;
    self.labelCommunityName.text = [NSString stringWithFormat:COMMUNITY_NAME_FORMAT,[[UserInformation instance] currentCommunity].communityName];
    [notificationDataManager clear];
    [self sendGetNotificationRequest];
}

#pragma mark - Communication Delegate

- (void)ProcessServerResponse:(id)response
{
    currentNotifications = response;
    [notificationDataManager populateData:currentNotifications.notifications];
    if(currentNotifications != nil && [currentNotifications.notifications count] > 0){
        NotificationParameter *param = [currentNotifications.notifications objectAtIndex:0];
        //param.content = @"非正常的贻笑大方的沙发里的空间发德萨发好的司法和萨帝华盛顿奋斗是浪费上帝粉红色的立法活动是雷锋活动顺利啊回复里的身份获得了撒坚持撒了地方看见电视啦放假就来说都快放假好 v 啊 v 与上帝大连市的风景非正常的贻笑大方的沙发里的空间发德萨发好的司法和萨帝华盛顿奋斗是浪费上帝粉红色的立法活动是雷锋活动顺利啊回复里的身份获得了撒坚持撒了地方看见电视啦放假就来说都快放假好 v 啊 v 与上帝大连市的风景非正常的贻笑大方的沙发里的空间发德萨发好的司法和萨帝华盛顿奋斗是浪费上帝粉红色的立法活动是雷锋活动顺利啊回复里的身份获得了撒坚持撒了地方看见电视啦放假就来说都快放假好 v 啊 v 与上帝大连市的风景非正常的贻笑大方的沙发里的空间发德萨发好的司法和萨帝华盛顿奋斗是浪费上帝粉红色的立法活动是雷锋活动顺利啊回复里的身份获得了撒坚持撒了地方看见电视啦放假就来说都快放假好 v 啊 v 与上帝大连市的风景非正常的贻笑大方的沙发里的空间发德萨发好的司法和萨帝华盛顿奋斗是浪费上帝粉红色的立法活动是雷锋活动顺利啊回复里的身份获得了撒坚持撒了地方看见电视啦放假就来说都快放假好 v 啊 v 与上帝大连市的风景非正常的贻笑大方的沙发里的空间发德萨发好的司法和萨帝华盛顿奋斗是浪费上帝粉红色的立法活动是雷锋活动顺利啊回复里的身份获得了撒坚持撒了地方看见电视啦放假就来说都快放假好 v 啊 v 与上帝大连市的风景非正常的贻笑大方的沙发里的空间发德萨发好的司法和萨帝华盛顿奋斗是浪费上帝粉红色的立法活动是雷锋活动顺利啊回复里的身份获得了撒坚持撒了地方看见电视啦放假就来说都快放假好 v 啊 v 与上帝大连市的风景非正常的贻笑大方的沙发里的空间发德萨发好的司法和萨帝华盛顿奋斗是浪费上帝粉红色的立法活动是雷锋活动顺利啊回复里的身份获得了撒坚持撒了地方看见电视啦放假就来说都快放假好 v 啊 v 与上帝大连市的风景非正常的贻笑大方的沙发里的空间发德萨发好的司法和萨帝华盛顿奋斗是浪费上帝粉红色的立法活动是雷锋活动顺利啊回复里的身份获得了撒坚持撒了地方看见电视啦放假就来说都快放假好 v 啊 v 与上帝大连市的风景非正常的贻笑大方的沙发里的空间发德萨发好的司法和萨帝华盛顿奋斗是浪费上帝粉红色的立法活动是雷锋活动顺利啊回复里的身份获得了撒坚持撒了地方看见电视啦放假就来说都快放假好 v 啊 v 与上帝大连市的风景非正常的贻笑大方的沙发里的空间发德萨发好的司法和萨帝华盛顿奋斗是浪费上帝粉红色的立法活动是雷锋活动顺利啊回复里的身份获得了撒坚持撒了地方看见电视啦放假就来说都快放假好 v 啊 v 与上帝大连市的风景";
    }
    [self.tableInformations reloadData];
    self.tableHeight.constant = self.tableInformations.contentSize.height;
    [self.view layoutIfNeeded];
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
    [self.tableInformations reloadData];
    self.tableHeight.constant = self.tableInformations.contentSize.height;
    [self.view layoutIfNeeded];
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
    [self sendGetNotificationRequest];
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
    NotificationDetailViewController *detailController = (NotificationDetailViewController *)segue.destinationViewController;
    NotificationParameter *param = [[notificationDataManager allData] objectAtIndex:currentSelectIndex];
    detailController.notification = param;
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


@end

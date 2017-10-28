//
//  OrderViewController.m
//  zhongying
//
//  Created by lk on 14-4-24.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import "OrderViewController.h"
#import "CommonUtilities.h"
#import "CommonConsts.h"
#import "UserInformation.h"
#import "GetOrdersRequestParameter.h"
#import "OrderParameter.h"
#import "OrderCell.h"
#import "OrderDetailViewController.h"

#define ORDER_CELL_REUSE_IDENTIFIER             @"Order"
#define DETAIL_SEGUE_IDENTIFIER                 @"Detail"

@interface OrderViewController ()

- (void)sendGetOrdersRequest;
- (void)sendGetOrdersRequestWithPage:(int)page andPageSize:(int)pageSize;

@end

@implementation OrderViewController

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
    
    orderDataManager = [[PageDataManager alloc] initWithPageSize:DEFAULT_PAGE_SIZE];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated
{
    if([[orderDataManager allData] count] == 0){
        [self sendGetOrdersRequest];
    }
    else{
        [self sendGetOrdersRequestWithPage:1 andPageSize:[[orderDataManager allData] count]];
        [orderDataManager clear];
    }
}


#pragma mark - Private Methods

- (void)sendGetOrdersRequest
{
    [self sendGetOrdersRequestWithPage:[orderDataManager getNextLoadPage] andPageSize:DEFAULT_PAGE_SIZE];
}

- (void)sendGetOrdersRequestWithPage:(int)page andPageSize:(int)pageSize
{
    currentResponse = nil;
    
    GetOrdersRequestParameter *request = [[GetOrdersRequestParameter alloc] init];
    request.userId = [UserInformation instance].userId;
    request.password = [UserInformation instance].password;
    request.page = page;
    request.pageSize = pageSize;
    
    [[CommunicationManager instance] getOrders:request withDelegate:self];
    [[CommonUtilities instance] showNetworkConnecting:self];
}

#pragma mark - Data table Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [[orderDataManager allData] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 84;
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
    OrderParameter *param = [[orderDataManager allData] objectAtIndex:index];
    OrderCell *cell = [tableView dequeueReusableCellWithIdentifier:ORDER_CELL_REUSE_IDENTIFIER forIndexPath:indexPath];
    
    cell.labelSnNo.text = param.orderSn;
    cell.labelTime.text = param.time;
    cell.labelStatus.text = param.status;
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
    [orderDataManager populateData:currentResponse.orders];
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
    [self sendGetOrdersRequest];
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
    self.hidesBottomBarWhenPushed = YES;
    OrderDetailViewController *controller = (OrderDetailViewController *)segue.destinationViewController;
    OrderParameter *order = [[orderDataManager allData] objectAtIndex:currentSelectIndex];
    controller.orderId = order.orderId;
    controller.finishController = self;
}


@end

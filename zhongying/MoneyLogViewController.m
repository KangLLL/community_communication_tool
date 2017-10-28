//
//  MoneyLogViewController.m
//  zhongying
//
//  Created by lk on 14-4-25.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import "MoneyLogViewController.h"
#import "CommonUtilities.h"
#import "CommonConsts.h"
#import "UserInformation.h"
#import "GetMoneyLogRequestParameter.h"
#import "MoneyLogParameter.h"
#import "MoneyLogCell.h"

#define MONEY_LOG_CELL_REUSE_IDENTIFIER     @"Log"

@interface MoneyLogViewController ()

- (void)sendGetMoneyLogsRequest;
- (void)sendGetMoneyLogsRequestWithPage:(int)page andPageSize:(int)pageSize;

@end

@implementation MoneyLogViewController

@synthesize labelRemainingMoney, tableInformations;

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
    
    logsDataManager = [[PageDataManager alloc] initWithPageSize:DEFAULT_PAGE_SIZE];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated
{
    if([[logsDataManager allData] count] == 0){
        [self sendGetMoneyLogsRequest];
    }
    else{
        [self sendGetMoneyLogsRequestWithPage:1 andPageSize:[[logsDataManager allData] count]];
        [logsDataManager clear];
    }
}

#pragma mark - Data table Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [[logsDataManager allData] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 2;
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
    MoneyLogParameter *param = [[logsDataManager allData] objectAtIndex:index];
    MoneyLogCell *cell = [tableView dequeueReusableCellWithIdentifier:MONEY_LOG_CELL_REUSE_IDENTIFIER forIndexPath:indexPath];
    
    cell.labelTime.text = param.time;
    cell.labelTips.text = param.tips;
    cell.labelMoney.text = param.money;
    cell.labelType.text = [param.money floatValue] > 0 ? @"收入" : @"支出";
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [[tableView cellForRowAtIndexPath:indexPath] setSelected:NO];
}

#pragma mark - Communication Delegate

- (void)ProcessServerResponse:(id)response
{
    currentResponse = response;
    [logsDataManager populateData:currentResponse.logs];
    if([[logsDataManager allData] count] > 0){
        MoneyLogParameter *param = [[logsDataManager allData] objectAtIndex:0];
        self.labelRemainingMoney.text = param.remainingMoney;
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

#pragma mark - Private Methods

- (void)sendGetMoneyLogsRequest
{
    [self sendGetMoneyLogsRequestWithPage:[logsDataManager getNextLoadPage] andPageSize:DEFAULT_PAGE_SIZE];
}

- (void)sendGetMoneyLogsRequestWithPage:(int)page andPageSize:(int)pageSize
{
    GetMoneyLogRequestParameter *request = [[GetMoneyLogRequestParameter alloc] init];
    request.userId = [UserInformation instance].userId;
    request.password = [UserInformation instance].password;
    request.page = page;
    request.pageSize = pageSize;
    [[CommunicationManager instance] getMoneyLog:request withDelegate:self];
    [[CommonUtilities instance] showNetworkConnecting:self];
}

#pragma mark - EGORefreshTableHeaderDelegate Methods
-(void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView*)view{
    isReloading = YES;
    [self sendGetMoneyLogsRequest];
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

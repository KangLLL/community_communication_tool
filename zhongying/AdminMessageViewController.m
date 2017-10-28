//
//  AdminMessageViewController.m
//  zhongying
//
//  Created by lk on 14-5-27.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import "AdminMessageViewController.h"
#import "UserInformation.h"
#import "CommonUtilities.h"
#import "CommonHelper.h"
#import "CommonConsts.h"
#import "AdminMessageCell.h"
#import "GetAdminMessageRequestParameter.h"
#import "AdminMessageParameter.h"
#import "AdminMessageDetailViewController.h"

#define MESSAGE_CELL_REUSE_IDENTIFIER           @"Message"
#define READ_MESSAGE_SEGUE_IDENTIFIER           @"Detail"

@interface AdminMessageViewController ()

- (void)sendGetAdminMessageRequest;
- (void)sendGetAdminMessageRequestWithPage:(int)page andPageSize:(int)pageSize;

@end

@implementation AdminMessageViewController

@synthesize tableInformations;

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
    
    messageDataManager = [[PageDataManager alloc] initWithPageSize:DEFAULT_PAGE_SIZE];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated
{
    if([[messageDataManager allData] count] == 0){
        [self sendGetAdminMessageRequest];
    }
    else{
        [self sendGetAdminMessageRequestWithPage:1 andPageSize:[[messageDataManager allData] count]];
        [messageDataManager clear];
    }
}


#pragma mark - Private Methods

- (void)sendGetAdminMessageRequest
{
    [self sendGetAdminMessageRequestWithPage:[messageDataManager getNextLoadPage] andPageSize:DEFAULT_PAGE_SIZE];
}

- (void)sendGetAdminMessageRequestWithPage:(int)page andPageSize:(int)pageSize
{
    currentResponse = nil;
    
    GetAdminMessageRequestParameter *request = [[GetAdminMessageRequestParameter alloc] init];
    request.userId = [UserInformation instance].userId;
    request.password = [UserInformation instance].password;
    request.page = page;
    request.pageSize = pageSize;
    
    [[CommunicationManager instance] getAdminMessages:request withDelegate:self];
    [[CommonUtilities instance] showNetworkConnecting:self];
}

#pragma mark - Data table Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [[messageDataManager allData] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 35;
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
    AdminMessageParameter *param = [currentResponse.messages objectAtIndex:index];
    AdminMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:MESSAGE_CELL_REUSE_IDENTIFIER forIndexPath:indexPath];
    
    cell.labelTime.text = param.time;
    cell.labelTitle.text = param.title;
    cell.labelTitle.textColor = param.messageStatus == messageReaded ? [UIColor blackColor] : [UIColor redColor];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    currentSelectIndex = indexPath.section;
    [self performSegueWithIdentifier:READ_MESSAGE_SEGUE_IDENTIFIER sender:nil];
}

#pragma mark - EGORefreshTableHeaderDelegate Methods
-(void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView*)view{
    isReloading = YES;
    [self sendGetAdminMessageRequest];
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

#pragma mark - Communication Delegate

- (void)ProcessServerResponse:(id)response
{
    currentResponse = response;
    [messageDataManager populateData:currentResponse.messages];
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


#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.destinationViewController isKindOfClass:[AdminMessageDetailViewController class]]){
        AdminMessageDetailViewController *controller = (AdminMessageDetailViewController *)segue.destinationViewController;
        controller.adminMessage = [[messageDataManager allData] objectAtIndex:currentSelectIndex];
    }
}


@end

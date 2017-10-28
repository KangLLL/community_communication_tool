//
//  CommunityNewsViewController.m
//  zhongying
//
//  Created by lik on 14-4-10.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import "CommunityNewsCategoryViewController.h"
#import "CommonUtilities.h"
#import "CommonConsts.h"
#import "UserInformation.h"
#import "GetNewsCategoryRequestParameter.h"
#import "NewsCategoryCell.h"
#import "NewsCategoryParameter.h"
#import "NewsViewController.h"

#define CATEGORY_CELL_REUSE_IDENTIFIER      @"Category"
#define NEWS_SEGUE_IDENTIFIER               @"News"

@interface CommunityNewsCategoryViewController ()

- (void)sendGetNewsCategoryRequest;
- (void)sendGetNewsCategoryRequestWithPage:(int)page andPageSize:(int)pageSize;

@end

@implementation CommunityNewsCategoryViewController

@synthesize tableInformations, communitiesView, labelCommunity, tableHeight;

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
    cacher = [[DownloadCacher alloc] init];
    
    [self.communitiesView reloadData];
    [self.communitiesView setSelectIndex:[UserInformation instance].currentCommunityIndex];
    self.labelCommunity.text = [[UserInformation instance] currentCommunity].communityName;
    
    newsDataManager = [[PageDataManager alloc] initWithPageSize:DEFAULT_PAGE_SIZE];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated
{
    if([[newsDataManager allData] count] == 0){
        [self sendGetNewsCategoryRequest];
    }
    else{
        [self sendGetNewsCategoryRequestWithPage:1 andPageSize:[[newsDataManager allData] count]];
        [newsDataManager clear];
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

- (void)sendGetNewsCategoryRequest
{
    [self sendGetNewsCategoryRequestWithPage:[newsDataManager getNextLoadPage] andPageSize:DEFAULT_PAGE_SIZE];
}

- (void)sendGetNewsCategoryRequestWithPage:(int)page andPageSize:(int)pageSize
{
    currentResponse = nil;
    
    GetNewsCategoryRequestParameter *request = [[GetNewsCategoryRequestParameter alloc] init];
    request.communityId = [UserInformation instance].currentCommunity.communityId;
    request.userId = [UserInformation instance].userId;
    request.password = [UserInformation instance].password;
    request.page = page;
    request.pageSize = pageSize;
    
    [[CommunicationManager instance] getNewsCategories:request withDelegate:self];
    [[CommonUtilities instance] showNetworkConnecting:self];
}

#pragma mark - Data table Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [[newsDataManager allData] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
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
    NewsCategoryCell *cell = [tableView dequeueReusableCellWithIdentifier:CATEGORY_CELL_REUSE_IDENTIFIER forIndexPath:indexPath];
    NewsCategoryParameter *param = [[newsDataManager allData] objectAtIndex:index];
    cell.labelTitle.text = param.categoryName;
    cell.tag = index;
    [cacher getImageWithUrl:param.imageUrl andCell:cell inImageView:cell.imagePhoto withActivityView:cell.activityView];
    
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
    [self performSegueWithIdentifier:NEWS_SEGUE_IDENTIFIER sender:nil];
}

#pragma mark - FoldableView Delegate

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
    self.labelCommunity.text = [[UserInformation instance] currentCommunity].communityName;
    [newsDataManager clear];
    [self sendGetNewsCategoryRequest];
}

#pragma mark - Communication Delegate

- (void)ProcessServerResponse:(id)response
{
    currentResponse = response;
    [newsDataManager populateData:currentResponse.categories];
    [self.tableInformations reloadData];
    self.tableHeight.constant = self.tableInformations.contentSize.height;
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
    NSLog(@"%@",failInfo.message);
    [refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:self.tableInformations];
    isReloading = NO;
    [self showErrorMessage:failInfo.message];
}

- (void)ProcessCommunicationError:(NSError *)error
{
    [[CommonUtilities instance] hideNetworkConnecting];
    NSLog(@"%@",error.localizedDescription);
    [refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:self.tableInformations];
    isReloading = NO;
    [self showErrorMessage:error.localizedDescription];
}

#pragma mark - EGORefreshTableHeaderDelegate Methods
-(void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView*)view{
    isReloading = YES;
    [self sendGetNewsCategoryRequest];
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
    NewsViewController *controller = (NewsViewController *)segue.destinationViewController;
    controller.category = [[newsDataManager allData] objectAtIndex:currentSelectIndex];
}


@end

//
//  NewsViewController.m
//  zhongying
//
//  Created by lk on 14-4-22.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import "NewsViewController.h"
#import "CommonUtilities.h"
#import "UserInformation.h"
#import "CommonConsts.h"
#import "NewsCell.h"
#import "GetNewsRequestParameter.h"
#import "NewsParameter.h"
#import "NewsDetailViewController.h"

#define TITLE_TEXT_FORMAT                   @"[%@]%@"
#define NEWS_CELL_REUSE_IDENTIFIER          @"News"
#define DETAIL_SEGUE_INDENTIFIER            @"Detail"

#define NEWS_PAGE_SIZE                      20

@interface NewsViewController ()

- (void)sendGetNewsRequest;
- (void)sendGetNewsRequestWithPage:(int)page andPageSize:(int)pageSize;

@end

@implementation NewsViewController

@synthesize labelTitle, tableNews, category;

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
    self.labelTitle.text = [NSString stringWithFormat:TITLE_TEXT_FORMAT,[[UserInformation instance] currentCommunity].communityName, self.category.categoryName];
    
    newsDataManager = [[PageDataManager alloc] initWithPageSize:NEWS_PAGE_SIZE];
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
        [self sendGetNewsRequest];
    }
    else{
        [self sendGetNewsRequestWithPage:1 andPageSize:[[newsDataManager allData] count]];
        [newsDataManager clear];
    }
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
    return 65;
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
    NewsCell *cell = [tableView dequeueReusableCellWithIdentifier:NEWS_CELL_REUSE_IDENTIFIER forIndexPath:indexPath];
    NewsParameter *param = [[newsDataManager allData] objectAtIndex:index];
    cell.labelTitle.text = param.title;
    cell.labelTime.text = param.time;
    cell.labelContent.text = param.description;
    cell.labelAuthor.text = param.author;
    
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
    [self performSegueWithIdentifier:DETAIL_SEGUE_INDENTIFIER sender:nil];
}

#pragma mark - Private Methods

- (void)sendGetNewsRequest
{
    [self sendGetNewsRequestWithPage:[newsDataManager getNextLoadPage] andPageSize:NEWS_PAGE_SIZE];
}

- (void)sendGetNewsRequestWithPage:(int)page andPageSize:(int)pageSize
{
    currentResponse = nil;
    GetNewsRequestParameter *request = [[GetNewsRequestParameter alloc] init];
    request.userId = [UserInformation instance].userId;
    request.password = [UserInformation instance].password;
    request.categoryId = self.category.categoryId;
    request.page = page;
    request.pageSize = pageSize;
    [[CommunicationManager instance] getNews:request withDelegate:self];
    [[CommonUtilities instance] showNetworkConnecting:self];
}

#pragma mark - Communication Delegate

- (void)ProcessServerResponse:(id)response
{
    currentResponse = response;
    [newsDataManager populateData:currentResponse.news];
    [self.tableNews reloadData];
    CGFloat height = MAX(self.tableNews.contentSize.height, self.tableNews.frame.size.height);
    if(refreshHeaderView == nil){
        EGORefreshTableHeaderView *view =[[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0.0f, height, self.tableNews.bounds.size.width, self.tableNews.bounds.size.height)];
        view.delegate = self;
        [self.tableNews addSubview:view];
        refreshHeaderView = view;
    }
    else{
        CGRect newFrame = refreshHeaderView.frame;
        newFrame.origin.y = height;
        refreshHeaderView.frame = newFrame;
        [refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:self.tableNews];
        isReloading = NO;
    }
    [[CommonUtilities instance] hideNetworkConnecting];
}

- (void)ProcessServerFail:(ServerFailInformation *)failInfo
{
    [[CommonUtilities instance] hideNetworkConnecting];
    [refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:self.tableNews];
    isReloading = NO;
    NSLog(@"%@",failInfo.message);
    [self showErrorMessage:failInfo.message];
}

- (void)ProcessCommunicationError:(NSError *)error
{
    [[CommonUtilities instance] hideNetworkConnecting];
    [refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:self.tableNews];
    isReloading = NO;
    NSLog(@"%@",error.localizedDescription);
    [self showErrorMessage:error.localizedDescription];
}

#pragma mark - EGORefreshTableHeaderDelegate Methods
-(void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView*)view{
    isReloading = YES;
    [self sendGetNewsRequest];
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
    NewsDetailViewController *controller = (NewsDetailViewController *)segue.destinationViewController;
    controller.news = [[newsDataManager allData] objectAtIndex:currentSelectIndex];
}


@end

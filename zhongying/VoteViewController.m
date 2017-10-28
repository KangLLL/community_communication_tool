//
//  VoteViewController.m
//  zhongying
//
//  Created by lik on 14-4-7.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import "VoteViewController.h"
#import "CommonUtilities.h"
#import "CommunicationManager.h"
#import "GetVoteListRequestParameter.h"
#import "UserInformation.h"
#import "VoteParameter.h"
#import "VoteOptionParameter.h"
#import "SingleVoteCell.h"
#import "MultiplyVoteCell.h"
#import "CommonHelper.h"
#import "CommonConsts.h"
#import "AddVoteRequestParameter.h"

#define SINGLE_CELL_REUSE_IDENTIFIER            @"Single"
#define MUTIPLY_CELL_REUSE_IDENTIFIER           @"Multiply"

#define COMMUNITY_NAME_FORMAT                   @"[%@]"


@interface VoteViewController ()

- (void)sendGetVoteRequest;
- (void)sendGetVoteRequestWithPage:(int)page andPageSize:(int)pageSize;

@end

@implementation VoteViewController

@synthesize tableInformations, communitiesView, labelCommunity;

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
    self.labelCommunity.text = [NSString stringWithFormat:COMMUNITY_NAME_FORMAT,[UserInformation instance].currentCommunity.communityName];
    
    imageSingleSelect = [UIImage imageNamed:SELECTION_DEFAULT_SELECT_IMAGE_NAME];
    imageSingleUnselct = [UIImage imageNamed:SELECTION_DEFAULT_UNSELECT_IMAGE_NAME];
    imageMultiplySelect = [UIImage imageNamed:CHECK_DEFAULT_SELECT_IMAGE_NAME];
    imageMultiplyUnselect = [UIImage imageNamed:UNCHECK_DEFAULT_SELECT_IMAGE_NAME];
    votes = [NSMutableDictionary dictionary];
    
    [self.communitiesView reloadData];
    [self.communitiesView setSelectIndex:[UserInformation instance].currentCommunityIndex];
    
    voteDataManager = [[PageDataManager alloc] initWithPageSize:DEFAULT_PAGE_SIZE];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated
{
    if([[voteDataManager allData] count] == 0){
        [self sendGetVoteRequest];
    }
    else{
        [self sendGetVoteRequestWithPage:1 andPageSize:[[voteDataManager allData] count]];
        [voteDataManager clear];
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

- (IBAction)vote:(id)sender
{
    UIButton *button = (UIButton *)sender;
    int index = [self.tableInformations indexPathForCell:[CommonHelper getParentCell:button]].section;
    
    VoteParameter *param = [[voteDataManager allData] objectAtIndex:index];
    AddVoteRequestParameter *request = [[AddVoteRequestParameter alloc] init];
    request.userId = [UserInformation instance].userId;
    request.password = [UserInformation instance].password;
    request.voteId = param.voteId;
    request.answer = param.mySelection;
    
    [[CommunicationManager instance] vote:request withDelegate:self];
    isVoting = YES;
}

#pragma mark - Private Methods

- (void)sendGetVoteRequest
{
    [self sendGetVoteRequestWithPage:[voteDataManager getNextLoadPage] andPageSize:DEFAULT_PAGE_SIZE];
}

- (void)sendGetVoteRequestWithPage:(int)page andPageSize:(int)pageSize
{
    currentResponse = nil;
    
    GetVoteListRequestParameter *request = [[GetVoteListRequestParameter alloc] init];
    request.communityId = [UserInformation instance].currentCommunity.communityId;
    request.userId = [UserInformation instance].userId;
    request.password = [UserInformation instance].password;
    request.page = page;
    request.pageSize = pageSize;
    
    [[CommunicationManager instance] getVotes:request withDelegate:self];
    [[CommonUtilities instance] showNetworkConnecting:self];
}

#pragma mark - Data table Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [[voteDataManager allData] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    int index = indexPath.section;
    VoteParameter *info = [[voteDataManager allData] objectAtIndex:index];
    if(info.voteType == voteSingle){
        return [SingleVoteCell getCellHeightAccordingToOptions:[info.options count]];
    }
    else{
        return [MultiplyVoteCell getCellHeightAccordingToOptions:[info.options count]];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
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
    VoteParameter *info = [[voteDataManager allData] objectAtIndex:index];
    if(info.voteType == voteSingle){
        NSString *identifier = [NSString stringWithFormat:SINGLE_CELL_REUSE_IDENTIFIER];
        SingleVoteCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
        cell.selectImage = imageSingleSelect;
        cell.unselectImage = imageSingleUnselct;
        
        if(info.isVoted){
            if([[votes allKeys] containsObject:info.voteId]){
                [votes removeObjectForKey:info.voteId];
            }
        }
        else{
            if(![[votes allKeys] containsObject:info.voteId]){
                [votes setObject:[NSMutableArray array] forKey:info.voteId];
            }
            info.mySelection = [votes objectForKey:info.voteId];
        }
       
        [cell initWithInformation:info withVoteTarget:self andSelector:@selector(vote:)];
        return cell;
    }
    else{
        NSString *identifier = [NSString stringWithFormat:MUTIPLY_CELL_REUSE_IDENTIFIER];
        MultiplyVoteCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
        cell.selectImage = imageMultiplySelect;
        cell.unselectImage = imageMultiplyUnselect;
        if([[votes allKeys] containsObject:info.voteId])
        {
            if(info.isVoted){
                [votes removeObjectForKey:info.voteId];
            }
            else{
                info.mySelection = [votes objectForKey:info.voteId];
            }
        }
        [cell initWithInformation:info withVoteTarget:self andSelector:@selector(vote:)];
        return cell;
    }
}


- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath
{
    return NO;
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
    [voteDataManager clear];
    [votes removeAllObjects];
    [self sendGetVoteRequest];
}

#pragma mark - Communication Delegate

- (void)ProcessServerResponse:(id)response
{
    if(isVoting)
    {
        [self sendGetVoteRequestWithPage:1 andPageSize:[[voteDataManager allData] count]];
        [voteDataManager clear];
        isVoting = NO;
    }
    else{
        currentResponse = response;
        [voteDataManager populateData:currentResponse.votes];
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
}

- (void)ProcessServerFail:(ServerFailInformation *)failInfo
{
    [[CommonUtilities instance] hideNetworkConnecting];
    isVoting = NO;
    [self.tableInformations reloadData];
    [refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:self.tableInformations];
    isReloading = NO;
    NSLog(@"%@",failInfo.message);
    [self showErrorMessage:failInfo.message];
}

- (void)ProcessCommunicationError:(NSError *)error
{
    isVoting = NO;
    [[CommonUtilities instance] hideNetworkConnecting];
    [refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:self.tableInformations];
    isReloading = NO;
    NSLog(@"%@",error.localizedDescription);
    [self showErrorMessage:error.localizedDescription];
}

#pragma mark - EGORefreshTableHeaderDelegate Methods
-(void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView*)view{
    isReloading = YES;
    [self sendGetVoteRequest];
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

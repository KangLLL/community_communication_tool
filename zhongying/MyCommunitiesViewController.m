//
//  MyCommunitiesViewController.m
//  zhongying
//
//  Created by lik on 14-3-21.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import "MyCommunitiesViewController.h"
#import "CommonUtilities.h"
#import "CommonHelper.h"
#import "CommonConsts.h"
#import "CommunicationManager.h"
#import "UserInformation.h"
#import "CommunityCell.h"
#import "GetMyCommunitiesRequestParameter.h"
#import "GetMyCommunitiesResponseParameter.h"
#import "MyCommunityParameter.h"
#import "UnbindCommunityRequestParameter.h"


#define HEAD_CELL_REUSE_IDENTIFIER          @"Head"
#define CONTENT_CELL_REUSE_IDENTIFIER       @"Content"

#define ER_WEI_MA_PASSED_DISPLAY_TEXT       @"开通"
#define ER_WEI_MA_NOT_PASSED_DISPLAY_TEXT   @"未开通"
#define ER_WEI_MA_PROCESS_DISPLAY_TEXT      @"处理中"

#define ADD_COMMUNITY_SEGUE_IDENTIFIER      @"Add"
#define COMMUNITY_DETAIL_SEGUE_IDENTIFIER   @"Detail"

@interface MyCommunitiesViewController ()

- (void)sendGetMyCommunitiesRequest;
- (void)sendDeleteMyCommunityRequest:(int)index;

@end

@implementation MyCommunitiesViewController

@synthesize tableCommunities;

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
    self.tableCommunities.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];

    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated
{
    [self sendGetMyCommunitiesRequest];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Private Methods

- (void)sendGetMyCommunitiesRequest
{
    currentFunction = communityGet;
    
    currentCommunities = nil;
    [UserInformation instance].communities = nil;
    [UserInformation instance].currentCommunityIndex = -1;
    GetMyCommunitiesRequestParameter *request = [[GetMyCommunitiesRequestParameter alloc] init];
    request.userId = [UserInformation instance].userId;
    request.password = [UserInformation instance].password;
    request.isUserCenter = YES;
    [[CommunicationManager instance] getMyCommunities:request withDelegate:self];
    [[CommonUtilities instance] showNetworkConnecting:self];
}

- (void)sendDeleteMyCommunityRequest:(int)index
{
    currentFunction = communityDelete;
    
    MyCommunityParameter *param = [currentCommunities.communities objectAtIndex:index];
    UnbindCommunityRequestParameter *request = [[UnbindCommunityRequestParameter alloc] init];
    request.userId = [UserInformation instance].userId;
    request.password = [UserInformation instance].password;
    request.communityId = param.communityId;
    request.buildNo = param.buildingNo;
    request.floorNo = param.floorNo;
    request.roomNo = param.roomNo;
    [[CommunicationManager instance] unbindCommunity:request withDelegate:self];
}

#pragma mark - Data table Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(currentCommunities == nil){
        return 1;
    }
    else{
        return [currentCommunities.communities count] + 1;
    }
}


- (float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row == 0){
        return 44;
    }
    else{
        return 60;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row == 0){
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: HEAD_CELL_REUSE_IDENTIFIER forIndexPath:indexPath];
        return cell;
    }
    else{
        CommunityCell *cell = (CommunityCell *)[tableView dequeueReusableCellWithIdentifier:CONTENT_CELL_REUSE_IDENTIFIER forIndexPath:indexPath];
        MyCommunityParameter *community = [currentCommunities.communities objectAtIndex:indexPath.row - 1];
        
        cell.labelName.text = [NSString stringWithFormat:@"%@(%@-%@-%@)",community.communityName,community.buildingNo,community.floorNo,community.roomNo];
        [cell.labelName sizeToFit];
        cell.labelPeopleNumber.text = community.communityPeopleCount;
        cell.labelTwoDimensionCode.text = community.twoDimensionCodeStatus == ewmPassed ? ER_WEI_MA_PASSED_DISPLAY_TEXT : community.twoDimensionCodeStatus == ewmNotPassed ? ER_WEI_MA_NOT_PASSED_DISPLAY_TEXT : ER_WEI_MA_PROCESS_DISPLAY_TEXT;
        
        
        NSString *plainText = [NSString stringWithFormat:@"%@", cell.buttonCheckCharge.titleLabel.text];
        NSMutableAttributedString *styledText = [[NSMutableAttributedString alloc] initWithString:plainText];
        
        NSDictionary *attributes = @{NSUnderlineStyleAttributeName : [NSNumber numberWithInt:1]};
        NSRange range = [plainText rangeOfString:plainText];
        [styledText setAttributes:attributes range:range];
        cell.buttonCheckCharge.titleLabel.attributedText = styledText;
        
        plainText = [NSString stringWithFormat:@"%@", cell.buttonUnbind.titleLabel.text];
        styledText = [[NSMutableAttributedString alloc] initWithString:plainText];
        range = [plainText rangeOfString:plainText];
        [styledText setAttributes:attributes range:range];
        cell.buttonUnbind.titleLabel.attributedText = styledText;
        
        plainText = [NSString stringWithFormat:@"%@", cell.buttonDetail.titleLabel.text];
        styledText = [[NSMutableAttributedString alloc] initWithString:plainText];
        range = [plainText rangeOfString:plainText];
        [styledText setAttributes:attributes range:range];
        cell.buttonDetail.titleLabel.attributedText = styledText;
        
        return cell;
    }
}

#pragma mark - Button Actions

- (IBAction)checkCharge:(id)sender
{
    UIButton *button = (UIButton *)sender;
    int index = [tableCommunities indexPathForCell:[CommonHelper getParentCell:button]].row - 1;
    [UserInformation instance].currentCommunityIndex = index;
    [self performSegueWithIdentifier:HOME_PAYMENT_SEGUE_IDENTIFIER sender:nil];
    //[self toHomeToController:HOME_PAYMENT_SEGUE_IDENTIFIER];
}

- (IBAction)showCommunityDetailInfo:(id)sender
{
    UIButton *button = (UIButton *)sender;
    int index = [tableCommunities indexPathForCell:[CommonHelper getParentCell:button]].row - 1;
    MyCommunityParameter *param = [currentCommunities.communities objectAtIndex:index];
    [[UserInformation instance] setCurrentCommunityId:param.communityId];
    [self performSegueWithIdentifier:COMMUNITY_DETAIL_SEGUE_IDENTIFIER sender:nil];
}

- (IBAction)unbind:(id)sender
{
    UIButton *button = (UIButton *)sender;
    int index = [tableCommunities indexPathForCell:[CommonHelper getParentCell:button]].row - 1;
    [self sendDeleteMyCommunityRequest:index];
}

- (IBAction)bind:(id)sender
{
    self.hidesBottomBarWhenPushed = YES;
    [self performSegueWithIdentifier:ADD_COMMUNITY_SEGUE_IDENTIFIER sender:nil];
}

#pragma mark - Communication Delegate

- (void)ProcessServerResponse:(id)response
{
    if(currentFunction == communityGet){
        currentCommunities = response;
        [self.tableCommunities reloadData];
        
        [[UserInformation instance] initialCommunities:response];
        if([currentCommunities.communities count] > 0){
            [UserInformation instance].currentCommunityIndex = 0;
        }
        else{
            [UserInformation instance].currentCommunityIndex = -1;
        }
        [[CommonUtilities instance] hideNetworkConnecting];
    }
    else{
        [self sendGetMyCommunitiesRequest];
    }
}

- (void)ProcessServerFail:(ServerFailInformation *)failInfo
{
    [[CommonUtilities instance] hideNetworkConnecting];
    NSLog(@"%@",failInfo.message);
    [self showErrorMessage:failInfo.message];
    [self.tableCommunities reloadData];
}

- (void)ProcessCommunicationError:(NSError *)error
{
    [[CommonUtilities instance] hideNetworkConnecting];
    NSLog(@"%@",error.localizedDescription);
    [self showErrorMessage:error.localizedDescription];
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

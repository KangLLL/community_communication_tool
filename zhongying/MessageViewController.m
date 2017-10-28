//
//  MessageViewController.m
//  zhongying
//
//  Created by lk on 14-4-15.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import "MessageViewController.h"
#import "UserInformation.h"
#import "CommonUtilities.h"
#import "CommunicationManager.h"
#import "GetUnreadNotificationResponseParameter.h"
#import "MessageCenterCell.h"

#define MESSAGE_CENTER_CELL_REUSE_IDENTIFIER        @"CenterCell"

#define NOTIFICATION_SEGUE_IDENTIFIER               @"Notification"
#define NEIGHBOUR_SEGUE_IDENTIFIER                  @"Neighbour"
#define ADMIN_SEGUE_IDENTIFIER                      @"Admin"

@interface MessageViewController ()

- (void)sendGetNotificationCountRequest;

@end

@implementation MessageViewController

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
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated
{
    [self sendGetNotificationCountRequest];
}

#pragma mark - Private Methods

- (void)sendGetNotificationCountRequest
{
    currentResponse = nil;
    
    GetUnreadNotificationRequestParameter *request = [[GetUnreadNotificationRequestParameter alloc] init];
    request.userId = [UserInformation instance].userId;
    request.password = [UserInformation instance].password;
    request.communityId = [[UserInformation instance] currentCommunity].communityId;
    
    [[CommunicationManager instance] getUnreadNotifications:request withDelegate:self];
    [[CommonUtilities instance] showNetworkConnecting:self];
}

#pragma mark - Data table Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MessageCenterCell *cell = [tableView dequeueReusableCellWithIdentifier:MESSAGE_CENTER_CELL_REUSE_IDENTIFIER forIndexPath:indexPath];
    
    switch (indexPath.row) {
        case 0:
            cell.labelTitle.text = @"小区通知";
            if(currentResponse != nil){
                cell.labelCount.text = [NSString stringWithFormat:@"(%@)",currentResponse.notificationCount];
            }
            break;
        case 1:
            cell.labelTitle.text = @"邻居留言";
            if(currentResponse != nil){
                cell.labelCount.text = [NSString stringWithFormat:@"(%@)",currentResponse.neighbourMessageCount];
            }
            break;
        case 2:
            cell.labelTitle.text = @"平台通知";
            break;
        case 3:
            cell.labelTitle.text = @"平台推送";
            break;
        default:
            break;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    switch (indexPath.row) {
        case 0:
            [self performSegueWithIdentifier:NOTIFICATION_SEGUE_IDENTIFIER sender:nil];
            break;
        case 1:
            [self performSegueWithIdentifier:NEIGHBOUR_SEGUE_IDENTIFIER sender:nil];
            break;
        case 2:
            [self performSegueWithIdentifier:ADMIN_SEGUE_IDENTIFIER sender:nil];
            break;
        default:
            break;
    }
}

#pragma mark - Communication Delegate

- (void)ProcessServerResponse:(id)response
{
    currentResponse = response;
    [self. tableInformations reloadData];
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


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    self.hidesBottomBarWhenPushed = YES;
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


@end

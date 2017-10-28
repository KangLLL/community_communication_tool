//
//  HobbyMessageListViewController.m
//  zhongying
//
//  Created by LI K on 15/4/14.
//  Copyright (c) 2014 lik. All rights reserved.
//

#import "HobbyMessageListViewController.h"
#import "UserInformation.h"
#import "CommonUtilities.h"
#import "CommonHelper.h"
#import "HobbyMessageCell.h"
#import "AllHobbyMessageParameter.h"
#import "GetAllHobbyMessagesRequestParameter.h"
#import "HobbyMessageViewController.h"
#import "HobbyPeopleParameter.h"

#define MESSAGE_CELL_REUSE_IDENTIFIER           @"Hobby"
#define SHOW_MESSAGE_SEGUE_IDENTIFIER           @"Show"

@interface HobbyMessageListViewController ()

- (void)sendGetHobbyMessageRequest;

@end

@implementation HobbyMessageListViewController

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
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated
{
    [self sendGetHobbyMessageRequest];
}


#pragma mark - Private Methods

- (void)sendGetHobbyMessageRequest
{
    currentResponse = nil;
    
    GetAllHobbyMessagesRequestParameter *request = [[GetAllHobbyMessagesRequestParameter alloc] init];
    request.userId = [UserInformation instance].userId;
    request.password = [UserInformation instance].password;
    
    [[CommunicationManager instance] getAllHobbyMessages:request withDelegate:self];
    [[CommonUtilities instance] showNetworkConnecting:self];
}

#pragma mark - Data table Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if(currentResponse == nil){
        return 0;
    }
    else{
        return [currentResponse.messages count];
    }
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
    AllHobbyMessageParameter *param = [currentResponse.messages objectAtIndex:index];
    HobbyMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:MESSAGE_CELL_REUSE_IDENTIFIER forIndexPath:indexPath];
    
    cell.labelName.text = param.userName;
    cell.labelTime.text = param.time;
    cell.labelMessage.text = param.content;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    currentSelectIndex = indexPath.section;
    [self performSegueWithIdentifier:SHOW_MESSAGE_SEGUE_IDENTIFIER sender:nil];
}

#pragma mark - Communication Delegate

- (void)ProcessServerResponse:(id)response
{
    currentResponse = response;
    
    [self.tableInformations reloadData];
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

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    self.hidesBottomBarWhenPushed = YES;
    HobbyMessageViewController *controller = (HobbyMessageViewController *)segue.destinationViewController;
    AllHobbyMessageParameter *message = [currentResponse.messages objectAtIndex:currentSelectIndex];
    HobbyPeopleParameter *param = [[HobbyPeopleParameter alloc] init];
    param.userId = message.userId;
    param.userName = message.userName;
    param.communityName = @"";
    controller.currentPeople = param;
}


@end

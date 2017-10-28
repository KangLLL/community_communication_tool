//
//  NeighbourMessageViewController.m
//  zhongying
//
//  Created by lik on 14-4-10.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import "NeighbourMessageViewController.h"
#import "CommonConsts.h"
#import "UserInformation.h"
#import "CommonUtilities.h"
#import "CommunicationManager.h"
#import "GetNeighbourMessagesRequestParameter.h"
#import "NeighbourMessageParameter.h"
#import "SendNeighbourMessageRequestParameter.h"
#import "NeighbourSelfCell.h"
#import "NeighbourOtherCell.h"

#define SELF_CELL_REUSE_IDENTIFIER  @"Self"
#define OTHER_CELL_REUSE_IDENTIFIER @"Other"
#define MY_USER_ID                  @"我"

@interface NeighbourMessageViewController ()

- (void)sendGetMessageRequest;

@end

@implementation NeighbourMessageViewController

@synthesize labelTitle, textViewMessage, bottomConstraint, tableContent, currentNeighbour;

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
    self.labelTitle.text = [NSString stringWithFormat:@"%@-%@",[[UserInformation instance]currentCommunity].communityName, self.currentNeighbour.name];
    self.tableContent.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    UIToolbar * topView = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, TEXT_VIEW_ACCESSOR_VIEW_HEIGHT)];
    [topView setBarStyle:UIBarStyleBlackOpaque];
    
    UIBarButtonItem * btnSpace = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    UIBarButtonItem * doneButton = [[UIBarButtonItem alloc]initWithTitle:@"确定" style:UIBarButtonItemStyleDone target:self action:@selector(dismissKeyboard)];
    
    NSArray * buttonsArray = [NSArray arrayWithObjects:btnSpace,doneButton,nil];
    
    [topView setItems:buttonsArray];
    [self.textViewMessage setInputAccessoryView:topView];
    
    [self registerTextField:self.textViewMessage];
    // Do any additional setup after loading the view.
}

- (void)viewDidAppear:(BOOL)animated
{
    [self sendGetMessageRequest];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Button Action
- (IBAction)sendMessage:(id)sender
{
    if([self.textViewMessage.text length] > 0){
        currentFunction = neighbourMessageSend;
        
        SendNeighbourMessageRequestParameter *request = [[SendNeighbourMessageRequestParameter alloc] init];
        request.userId = [UserInformation instance].userId;
        request.password = [UserInformation instance].password;
        request.toPeopleId = currentNeighbour.peopleId;
        request.content = self.textViewMessage.text;
        
        [[CommunicationManager instance] sendNeighbourMessage:request withDelegate:self];
        [[CommonUtilities instance] showNetworkConnecting:self];
        [self.textViewMessage resignFirstResponder];
    }
    NSLog(@"send!");
}

#pragma mark - Text Field Delegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    return YES;
}

#pragma mark - Private Methods
- (void)sendGetMessageRequest
{
    currentFunction = neighbourMessageGet;
    messageResponse = nil;
    GetNeighbourMessagesRequestParameter *request = [[GetNeighbourMessagesRequestParameter alloc] init];
    request.userId = [UserInformation instance].userId;
    request.password = [UserInformation instance].password;
    request.peopleId = self.currentNeighbour.peopleId;
    [[CommunicationManager instance] getNeighbourMessages:request withDelegate:self];
    [[CommonUtilities instance] showNetworkConnecting:self];
    
}

- (void)keyboardWillShow
{
    [UIView animateWithDuration:KEYBOARD_ANIMATE_TIME animations:^{
        self.bottomConstraint.constant = keyboardHeight;
        [self.view layoutIfNeeded];
    }];
}

- (void)keyboardWillHide
{
    [UIView animateWithDuration:KEYBOARD_ANIMATE_TIME animations:^{
        self.bottomConstraint.constant = 0;
        [self.view layoutIfNeeded];
    }];
}

- (void)dismissKeyboard
{
    [self.textViewMessage resignFirstResponder];
}

#pragma mark - Table Delegate

- (int)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(messageResponse == nil){
        return 0;
    }
    else{
        return [messageResponse.messages count];
    }
}


- (float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    int index = [messageResponse.messages count] - indexPath.row - 1;
    NeighbourMessageParameter *param = [messageResponse.messages objectAtIndex:index];
    if([param.fromId compare:MY_USER_ID] == NSOrderedSame){
        return [NeighbourSelfCell getCellHeightAccordingToContent:param.content];
    }
    else{
        return [NeighbourSelfCell getCellHeightAccordingToContent:param.content];
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    int index = [messageResponse.messages count] - indexPath.row - 1;
    NeighbourMessageParameter *param = [messageResponse.messages objectAtIndex:index];
    if([param.fromId compare:MY_USER_ID] == NSOrderedSame){
        NeighbourSelfCell *cell = [tableView dequeueReusableCellWithIdentifier:SELF_CELL_REUSE_IDENTIFIER forIndexPath:indexPath];
        cell.labelName.text = param.fromId;
        cell.labelTime.text = param.time;
        [cell setContent:param.content];
        return cell;
    }
    else{
        NeighbourOtherCell *cell = [tableView dequeueReusableCellWithIdentifier:OTHER_CELL_REUSE_IDENTIFIER forIndexPath:indexPath];
        cell.labelName.text = param.fromId;
        cell.labelTime.text = param.time;
        [cell setContent:param.content];
        return cell;
    }
}

#pragma mark - Communication Delegate

- (void)ProcessServerResponse:(id)response
{
    [[CommonUtilities instance] hideNetworkConnecting];
    if(currentFunction == neighbourMessageGet){
        messageResponse = response;
        [self.tableContent reloadData];
    }
    else{
        self.textViewMessage.text = @"";
        [self sendGetMessageRequest];
    }
    
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

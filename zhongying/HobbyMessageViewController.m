//
//  HobbyMessageViewController.m
//  zhongying
//
//  Created by lik on 14-4-9.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import "HobbyMessageViewController.h"
#import "CommonConsts.h"
#import "UserInformation.h"
#import "CommonUtilities.h"
#import "CommunicationManager.h"
#import "GetHobbyMessageRequestParameter.h"
#import "MessageParameter.h"
#import "HobbyOtherCell.h"
#import "HobbySelfCell.h"

#define SELF_CELL_REUSE_IDENTIFIER  @"Self"
#define OTHER_CELL_REUSE_IDENTIFIER @"Other"
#define MY_USER_ID                  @"我"

@interface HobbyMessageViewController ()

- (void)sendGetHobbyMessageRequest;

@end

@implementation HobbyMessageViewController

@synthesize labelTitle, textViewMessage, bottomConstraint, tableContent, currentPeople;

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
    self.labelTitle.text = [NSString stringWithFormat:@"%@-%@",self.currentPeople.communityName,self.currentPeople.userName];
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
    [self sendGetHobbyMessageRequest];
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
        currentFunction = hobbyMessageSend;
        
        SendHobbyMessageRequestParameter *request = [[SendHobbyMessageRequestParameter alloc] init];
        request.userId = [UserInformation instance].userId;
        request.password = [UserInformation instance].password;
        request.toUserId = currentPeople.userId;
        request.content = self.textViewMessage.text;
        
        [[CommunicationManager instance] sendHobbyMessage:request withDelegate:self];
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

- (void)sendGetHobbyMessageRequest
{
    currentFunction = hobbyMessageGet;
    
    GetHobbyMessageRequestParameter *request = [[GetHobbyMessageRequestParameter alloc] init];
    request.userId = [UserInformation instance].userId;
    request.password = [UserInformation instance].password;
    request.peopleId = self.currentPeople.userId;
    [[CommunicationManager instance] getHobbyMessages:request withDelegate:self];
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
    MessageParameter *param = [messageResponse.messages objectAtIndex:index];
    if([param.fromUserId compare:MY_USER_ID] == NSOrderedSame){
        return [HobbySelfCell getCellHeightAccordingToContent:param.content];
    }
    else{
        return [HobbyOtherCell getCellHeightAccordingToContent:param.content];
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    int index = [messageResponse.messages count] - indexPath.row - 1;
    MessageParameter *param = [messageResponse.messages objectAtIndex:index];
    if([param.fromUserId compare:MY_USER_ID] == NSOrderedSame){
        HobbySelfCell *cell = [tableView dequeueReusableCellWithIdentifier:SELF_CELL_REUSE_IDENTIFIER forIndexPath:indexPath];
        cell.labelName.text = param.fromUserId;
        cell.labelTime.text = param.time;
        [cell setContent:param.content];
        return cell;
    }
    else{
        HobbyOtherCell *cell = [tableView dequeueReusableCellWithIdentifier:OTHER_CELL_REUSE_IDENTIFIER forIndexPath:indexPath];
        cell.labelName.text = param.fromUserId;
        cell.labelTime.text = param.time;
        [cell setContent:param.content];
        return cell;
    }
}

/*

- (void)generateContent
{
    float totalHeight = currentHeight;
    
    for(int i = alreadLoadCount; i < [messageResponse.messages count]; i ++){
        MessageParameter *param = [messageResponse.messages objectAtIndex:i];
        
        UILabel *timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(LEFT_MARGIN, totalHeight, self.scorllContent.frame.size.width - LEFT_MARGIN - RIGHT_MARGIN, TIME_TITLE_HEIGHT)];
        timeLabel.textColor = [UIColor grayColor];
        timeLabel.textAlignment = NSTextAlignmentCenter;
        timeLabel.font = [UIFont systemFontOfSize:10];
        
        timeLabel.text = param.time;
        
        totalHeight += TIME_TITLE_HEIGHT;
        totalHeight += TIME_NAME_DISTANCE;
        
        UILabel *nameLabel = [[UILabel alloc] init];
        if([param.fromUserId compare:MY_USER_ID] == NSOrderedSame){
            nameLabel.frame = CGRectMake(self.scorllContent.frame.size.width - RIGHT_MARGIN - CONTENT_WIDTH, totalHeight, CONTENT_WIDTH, NAME_TITLE_HEIGHT);
            nameLabel.textAlignment = NSTextAlignmentRight;
           
        }
        else{
            nameLabel.frame = CGRectMake(LEFT_MARGIN, totalHeight, CONTENT_WIDTH, NAME_TITLE_HEIGHT);
            nameLabel.textAlignment = NSTextAlignmentLeft;
        }
        nameLabel.text = param.fromUserId;
        nameLabel.textColor = [UIColor grayColor];
        nameLabel.font = [UIFont systemFontOfSize:11];
        
        totalHeight += NAME_TITLE_HEIGHT;
        totalHeight += NAME_CONTENT_DISTANCE;
        
        UILabel *contentLabel = [[UILabel alloc] init];
        contentLabel.lineBreakMode = NSLineBreakByWordWrapping;
        contentLabel.numberOfLines = 0;
        contentLabel.font = [UIFont systemFontOfSize:12];
        CGSize textSize = [param.content sizeWithFont:[UIFont systemFontOfSize:12] constrainedToSize:CGSizeMake(CONTENT_WIDTH,10000) lineBreakMode:NSLineBreakByWordWrapping];
        
        if([param.fromUserId compare:MY_USER_ID] == NSOrderedSame){
            contentLabel.frame = CGRectMake(self.scorllContent.frame.size.width - RIGHT_MARGIN - CONTENT_WIDTH, totalHeight, CONTENT_WIDTH, textSize.height);
            contentLabel.textAlignment = NSTextAlignmentRight;
        }
        else{
            contentLabel.frame = CGRectMake(LEFT_MARGIN, totalHeight, CONTENT_WIDTH, textSize.height);
            contentLabel.textAlignment = NSTextAlignmentLeft;
        }
        contentLabel.text = param.content;
        totalHeight += textSize.height;
        totalHeight += CONTENT_TIME_DISTANCE;
        
        [self.scorllContent addSubview:timeLabel];
        [self.scorllContent addSubview:nameLabel];
        [self.scorllContent addSubview:contentLabel];
    }
    currentHeight = totalHeight;
    totalHeight += BOTTOM_MARGIN;
    alreadLoadCount = [messageResponse.messages count];
    
    self.scorllContent.contentSize = CGSizeMake(0, totalHeight);
    
    
        currentHeight = TOP_MARGIN;
     
    for(int i = 0; i < 100; i ++){
        UILabel *timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(LEFT_MARGIN, totalHeight, self.scorllContent.frame.size.width - LEFT_MARGIN - RIGHT_MARGIN, TIME_TITLE_HEIGHT)];
        timeLabel.textColor = [UIColor grayColor];
        timeLabel.textAlignment = NSTextAlignmentCenter;
        timeLabel.font = [UIFont systemFontOfSize:10];
        
        timeLabel.text = @"2013-09-007 20:20:20";
        
        totalHeight += TIME_TITLE_HEIGHT;
        totalHeight += TIME_NAME_DISTANCE;
        
        UILabel *nameLabel = [[UILabel alloc] init];
        if(i % 2 == 0){
            nameLabel.frame = CGRectMake(self.scorllContent.frame.size.width - RIGHT_MARGIN - 200, totalHeight, 200, NAME_TITLE_HEIGHT);
            nameLabel.textAlignment = NSTextAlignmentRight;
            nameLabel.text = @"我哦";
        }
        else{
            nameLabel.frame = CGRectMake(LEFT_MARGIN, totalHeight, 200, NAME_TITLE_HEIGHT);
            nameLabel.textAlignment = NSTextAlignmentLeft;
            nameLabel.text = @"曹操";
        }
        nameLabel.textColor = [UIColor grayColor];
        nameLabel.font = [UIFont systemFontOfSize:11];
        
        totalHeight += NAME_TITLE_HEIGHT;
        totalHeight += NAME_CONTENT_DISTANCE;
        
        UILabel *contentLabel = [[UILabel alloc] init];
        contentLabel.lineBreakMode = NSLineBreakByWordWrapping;
        contentLabel.numberOfLines = 0;
        contentLabel.font = [UIFont systemFontOfSize:13];
        NSString *a = [NSString stringWithFormat:@"%d,==========================%d,==============%d",i,i,i];
        CGSize textSize = [a sizeWithFont:[UIFont systemFontOfSize:13] constrainedToSize:CGSizeMake(200,10000) lineBreakMode:NSLineBreakByWordWrapping];
        
        if(i % 2 == 0){
            contentLabel.frame = CGRectMake(self.scorllContent.frame.size.width - RIGHT_MARGIN - 200, totalHeight, textSize.width, textSize.height);
            contentLabel.textAlignment = NSTextAlignmentRight;
            contentLabel.text = a;
        }
        else{
            nameLabel.frame = CGRectMake(LEFT_MARGIN, totalHeight, textSize.width, textSize.height);
            contentLabel.textAlignment = NSTextAlignmentLeft;
            contentLabel.text = a;
        }
        
        totalHeight += textSize.height;
        totalHeight += CONTENT_TIME_DISTANCE;
        
        [self.scorllContent addSubview:timeLabel];
        [self.scorllContent addSubview:nameLabel];
        [self.scorllContent addSubview:contentLabel];
    }
    totalHeight += BOTTOM_MARGIN;
    
    self.scorllContent.contentSize = CGSizeMake(0, totalHeight);
 }
*/


#pragma mark - Communication Delegate

- (void)ProcessServerResponse:(id)response
{
    [[CommonUtilities instance] hideNetworkConnecting];
    if(currentFunction == hobbyMessageGet){
        messageResponse = response;
        [self.tableContent reloadData];
    }
    else{
        self.textViewMessage.text = @"";
        [self sendGetHobbyMessageRequest];
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

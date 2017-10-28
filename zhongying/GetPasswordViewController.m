//
//  GetPasswordViewController.m
//  zhongying
//
//  Created by lik on 14-3-19.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import "GetPasswordViewController.h"
#import "CommunicationManager.h"
#import "CommonUtilities.h"
#import "SendEmailRequestParameter.h"

@interface GetPasswordViewController ()

- (void)sendGetPasswordRequest;

@end

@implementation GetPasswordViewController

@synthesize textUserName,textEmail;

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
    [self registerTextField:self.textUserName];
    [self registerTextField:self.textEmail];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Button Action

- (IBAction)getPassword:(id)sender
{
    [self sendGetPasswordRequest];
}

#pragma mark - Private Method

- (void)sendGetPasswordRequest
{
    [self resignFocus];
    
    if([self.textUserName.text length] == 0){
        [self showErrorMessage:@"请输入用户名"];
    }
    else if([self.textEmail.text length] == 0 || [self.textEmail.text rangeOfString:@"@"].length == 0){
        [self showErrorMessage:@"请输入正确的邮箱"];
    }
    else{
        SendEmailRequestParameter *request = [[SendEmailRequestParameter alloc] init];
        request.userName = self.textUserName.text;
        request.email = self.textEmail.text;
        [[CommunicationManager instance] sendEmail:request withDelegate:self];
        [[CommonUtilities instance] showNetworkConnecting:self];
    }
}

- (void)inputFinish
{
    [self sendGetPasswordRequest];
}

#pragma mark - Communication Delegate

- (void)ProcessServerResponse:(id)response
{
    [[CommonUtilities instance] hideNetworkConnecting];
    [self.navigationController popToViewController:self.backController animated:YES];
    [[CommonUtilities instance] showGlobeMessage:@"邮件已经发出"];
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

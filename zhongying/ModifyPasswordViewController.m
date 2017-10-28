//
//  ModifyPasswordViewController.m
//  zhongying
//
//  Created by lk on 14-4-14.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import "ModifyPasswordViewController.h"
#import "CommonUtilities.h"
#import "CommonConsts.h"
#import "UserInformation.h"
#import "EditPasswordReqeustParameter.h"

#import "UserCenterViewController.h"

@interface ModifyPasswordViewController ()

- (void)sendModifyRequest;

@end

@implementation ModifyPasswordViewController

@synthesize textOldPassword, textNewPassword, textComfirmPassword;

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

#pragma mark - Button Method
- (IBAction)modify:(id)sender
{
    [self.textOldPassword resignFirstResponder];
    [self.textNewPassword resignFirstResponder];
    [self.textComfirmPassword resignFirstResponder];

    [self sendModifyRequest];
}

#pragma mark - Text Field Delegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if(textField == self.textOldPassword){
        [self.textNewPassword becomeFirstResponder];
    }
    else if (textField == self.textNewPassword){
        [self.textComfirmPassword becomeFirstResponder];
    }
    else{
        [self.textComfirmPassword resignFirstResponder];
        [self sendModifyRequest];
    }
    return YES;
}

#pragma mark - Communication Delegate
- (void)ProcessServerResponse:(id)response
{
    [self showErrorMessage:@"修改成功"];
    [UserInformation instance].password = self.textNewPassword.text;
    [[NSUserDefaults standardUserDefaults] setObject:self.textNewPassword.text forKey:USER_PASSWORD_KEY];
    [[UserInformation instance] clear];
    [self toHomeToController:HOME_LOGIN_SEGUE_IDENTIFIER];
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

#pragma mark Private Methods

- (void)sendModifyRequest
{
    if([textOldPassword.text length] == 0){
        [self showErrorMessage:@"请输入原密码"];
    }
    else if([textNewPassword.text length] < 6){
        [self showErrorMessage:@"密码不能小于6位"];
    }
    else if([textNewPassword.text compare:textComfirmPassword.text] != NSOrderedSame){
        [self showErrorMessage:@"两次输入的密码不一样"];
    }
    else{
        EditPasswordReqeustParameter *request = [[EditPasswordReqeustParameter alloc] init];
        request.userId = [UserInformation instance].userId;
        request.password = [UserInformation instance].password;
        request.theNewPassword = self.textNewPassword.text;
        request.theOldPassword = self.textOldPassword.text;
        [[CommunicationManager instance] editPassword:request withDelegate:self];
        [[CommonUtilities instance] showNetworkConnecting:self];
    }
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

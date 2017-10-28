//
//  ConfirmPasswordViewController.m
//  zhongying
//
//  Created by lk on 14-4-28.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import "ConfirmPasswordViewController.h"
#import "UserInformation.h"
#import "CommonUtilities.h"
#import "RegisterRequestParameter.h"
#import "RegisterResponseParameter.h"

@interface ConfirmPasswordViewController ()

- (void)sendRegisterRequest;

@end

@implementation ConfirmPasswordViewController

@synthesize textPassword, textConfirmPassword, phone;

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
    [self registerTextField:self.textPassword];
    [self registerTextField:self.textConfirmPassword];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Private Method
- (void)inputFinish
{
    [self sendRegisterRequest];
}

- (void)sendRegisterRequest
{
    [self resignFocus];
    if([self.textConfirmPassword.text length] < 6 || [self.textPassword.text length] < 6){
        [self showErrorMessage:@"密码不能少于6位"];
    }
    else if(![self.textPassword.text isEqualToString:self.textConfirmPassword.text]){
        [self showErrorMessage:@"两次输入的密码不相同"];
    }
    else{
        RegisterRequestParameter *request = [[RegisterRequestParameter alloc] init];
        request.password = self.textPassword.text;
        request.phone = self.phone;
        [[CommunicationManager instance] registerUser:request withDelegate:self];
        [[CommonUtilities instance] showNetworkConnecting:self];
    }

}

#pragma mark - Button Action
- (IBAction)registerUser:(id)sender
{
    [self sendRegisterRequest];
}

#pragma mark - Communication Delegate
- (void)ProcessServerResponse:(id)response
{
    [[CommonUtilities instance] hideNetworkConnecting];
    [[CommonUtilities instance] showGlobeMessage:@"注册成功"];
    RegisterResponseParameter *param = response;
    [UserInformation instance].userId = param.userId;
    [UserInformation instance].password = param.password;
    [UserInformation instance].name = param.userName;
    [UserInformation instance].avatarPath = param.avatarPath;
    
    [self.navigationController popToViewController:self.finishController animated:YES];
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

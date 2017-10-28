//
//  LoginViewController.m
//  zhongying
//
//  Created by lik on 14-3-19.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import "LoginViewController.h"
#import "CommunicationManager.h"
#import "LoginRequestParameter.h"
#import "LoginResponseParameter.h"
#import "UserInformation.h"
#import "CommonUtilities.h"
#import "RegisterViewController.h"
#import "GetPasswordViewController.h"
#import "CommonConsts.h"
//#import "GetMyHobbiesRequestParameter.h"
//#import "GetMyHobbiesResponseParameter.h"

@interface LoginViewController ()

- (void)sendLoginRequest;

//- (void)sendGetMyHobbyRequest;

@end

@implementation LoginViewController
@synthesize textUserName, textPassword;

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
    [self registerTextField:self.textPassword];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)loginTouched:(id)sender
{
    [self sendLoginRequest];
}

- (void)inputFinish
{
    [self sendLoginRequest];
}

#pragma mark - Communication Delegate

- (void)ProcessServerResponse:(id)response
{
    if([response isKindOfClass:[LoginResponseParameter class]]){
        LoginResponseParameter *result = (LoginResponseParameter *)response;
        [UserInformation instance].userId = result.userId;
        [UserInformation instance].name = result.userName;
        [UserInformation instance].money = result.money;
        [UserInformation instance].point = result.point;
        [UserInformation instance].avatarPath = result.avatarPath;
        [UserInformation instance].password = result.password;
        
        [[NSUserDefaults standardUserDefaults] setObject:result.userId forKey:USER_ID_KEY];
        [[NSUserDefaults standardUserDefaults] setObject:result.password forKey:USER_PASSWORD_KEY];
        [[NSUserDefaults standardUserDefaults] setObject:result.userName forKey:USER_NAME_KEY];
        [[NSUserDefaults standardUserDefaults] setObject:result.avatarPath forKey:AVATAR_PATH_KEY];
        [[NSUserDefaults standardUserDefaults] setObject:result.phone forKey:USER_PHONE_KEY];
        //[[NSUserDefaults standardUserDefaults] synchronize];
        
        [self.navigationController popViewControllerAnimated:YES];
        [[CommonUtilities instance] hideNetworkConnecting];
        //[self sendGetMyHobbyRequest];
    }
    /*
    else{
        GetMyHobbiesResponseParameter *result = (GetMyHobbiesResponseParameter *)response;
        [UserInformation instance].hobbies = result.hobbies;
        [self.navigationController popViewControllerAnimated:YES];
        [[CommonUtilities instance] hideNetworkConnecting];
    }
     */
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

#pragma mark - Private Method

- (void)sendLoginRequest
{
    [self resignFocus];
    
    if([self.textUserName.text length] == 0){
        [self showErrorMessage:@"请输入用户名"];
    }
    else if([self.textPassword.text length] == 0){
        [self showErrorMessage:@"请输入密码"];
    }
    else{
        LoginRequestParameter *request = [[LoginRequestParameter alloc] init];
        request.name = self.textUserName.text;
        request.password = self.textPassword.text;
        [[CommunicationManager instance] login:request withDelegate:self];
        [[CommonUtilities instance] showNetworkConnecting:self];
    }
}

/*
- (void)sendGetMyHobbyRequest
{
    GetMyHobbiesRequestParameter *request = [[GetMyHobbiesRequestParameter alloc] init];
    request.userId = [UserInformation instance].userId;
    request.password = [UserInformation instance].password;
    [[CommunicationManager instance] getMyHobbies:request withDelegate:self];
    [[CommonUtilities instance] showNetworkConnecting:self];
}
*/
#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.destinationViewController isKindOfClass:[RegisterViewController class]]){
        RegisterViewController *controller = (RegisterViewController *)segue.destinationViewController;
        controller.backController = self.backController;
    }
    else if([segue.destinationViewController isKindOfClass:[GetPasswordViewController class]]){
        GetPasswordViewController *controller = (GetPasswordViewController *)segue.destinationViewController;
        controller.backController = self.backController;
    }
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


@end

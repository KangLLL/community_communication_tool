//
//  SigninViewController.m
//  zhongying
//
//  Created by lik on 14-3-19.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import "RegisterViewController.h"
#import "CommonUtilities.h"
#import "SendCodeRequestParameter.h"
#import "SendCodeResponseParameter.h"
#import "CommonConsts.h"
#import "ConfirmPasswordViewController.h"
#import "VerifyPhoneRequestParameter.h"
#import "StringResponse.h"

#define NEXT_SEGUE_IDENTIFIER           @"Next"

@interface RegisterViewController ()
- (void)updateVerifyStatus:(NSTimer *)timer;
- (void)sendVerifyPhoneRequest;
- (void)sendVerifyCodeRequest:(NSString *)url;
@end

@implementation RegisterViewController
@synthesize textPhone,textPhoneVerifyCode, labelVerifyTitle;

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
    
    [self registerTextField:self.textPhone];
    [self registerTextField:self.textPhoneVerifyCode];
    // Do any additional setup after loading the view.
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Private Methods
- (void)updateVerifyStatus:(NSTimer *)timer;
{
    NSDate *currentDate = [NSDate date];
    NSTimeInterval secondsInterval= [currentDate timeIntervalSinceDate:verifyCodeSendDate];
    if(secondsInterval > VERIFY_CODE_VALID_SECONDS){
        self.labelVerifyTitle.text = @"获取验证码";
        self.buttonVerify.userInteractionEnabled = YES;
        [verifyTimer invalidate];
    }
    else{
        int remainingSeconds = VERIFY_CODE_VALID_SECONDS - (int)secondsInterval;
        self.labelVerifyTitle.text = [NSString stringWithFormat:@"隔%d秒后再试",remainingSeconds];
    }
}

- (void)sendVerifyCodeRequest:(NSString *)url
{
    verifyCode = nil;
    SendCodeRequestParameter *request = [[SendCodeRequestParameter alloc] init];
    request.phoneNumber = self.textPhone.text;
    [[CommunicationManager instance] sendCode:request withUrl:url withDelegate:self];
    [[CommonUtilities instance] showNetworkConnecting:self];
}

- (void)sendVerifyPhoneRequest
{
    VerifyPhoneRequestParameter *request = [[VerifyPhoneRequestParameter alloc] init];
    request.phone = self.textPhone.text;
    [[CommunicationManager instance] verifyPhone:request withDelegate:self];
    [[CommonUtilities instance] showNetworkConnecting:self];
}

#pragma mark - Button Methods
- (IBAction)next:(id)sender
{
    if([self.textPhone.text length] != 11){
        [self showErrorMessage:@"请输入正确的电话号码"];
    }
    else if([self.textPhoneVerifyCode.text length] == 0 || verifyCode == nil){
        [self showErrorMessage:@"请输入验证码"];
    }
    else{
        if(![verifyCode isEqualToString:self.textPhoneVerifyCode.text]){
            [self showErrorMessage:@"验证码不对"];
        }
        else if([[NSDate date] timeIntervalSinceDate:verifyCodeSendDate] > VERIFY_CODE_VALID_SECONDS ){
            [self showErrorMessage:@"验证码已过期"];
        }
        else{
            [self performSegueWithIdentifier:NEXT_SEGUE_IDENTIFIER sender:nil];
        }
    }
}

- (IBAction)getVerifyCode:(id)sender
{
    [self resignFocus];
    if([self.textPhone.text length] == 11){
        [self sendVerifyPhoneRequest];
    }
    else{
        [self showErrorMessage:@"请输入正确的手机号码"];
    }
}

#pragma mark - Communication Delegate

- (void)ProcessServerResponse:(id)response
{
    [[CommonUtilities instance] hideNetworkConnecting];
    if([response isKindOfClass:[StringResponse class]]){
        StringResponse *s = response;
        [self sendVerifyCodeRequest:s.response];
    }
    else{
        SendCodeResponseParameter *param = response;
        verifyCode = param.code;
        verifyTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(updateVerifyStatus:) userInfo:nil repeats:YES];
        verifyCodeSendDate = [NSDate date];
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


#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    ConfirmPasswordViewController *controller = (ConfirmPasswordViewController *)segue.destinationViewController;
    controller.finishController = self.backController;
    controller.phone = self.textPhone.text;
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


@end

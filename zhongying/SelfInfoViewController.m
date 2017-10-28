//
//  SelfInfoViewController.m
//  zhongying
//
//  Created by lk on 14-4-17.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import "SelfInfoViewController.h"
#import "CommonEnum.h"
#import "CommonHelper.h"
#import "CommonConsts.h"
#import "CommonUtilities.h"
#import "UserInformation.h"

#import "GetMyInfoRequestParameter.h"
#import "EditMyInfoRequestParameter.h"
#import "SendCodeRequestParameter.h"
#import "VerifyPhoneRequestParameter.h"
#import "StringResponse.h"

@interface SelfInfoViewController ()

- (void)dismissKeyboard;

- (void)sendGetMyInfoRequest;
- (void)sendModifyInfoRequest;
- (void)sendVerifyCodeRequest:(NSString *)url;
- (void)sendVerifyPhoneRequest;

- (void)updateVerifyStatus:(NSTimer *)timer;

@end

#define VERTICAL_SPACE_WITH_VERIFY          46
#define VERTICAL_SPACE_WITHOUT_VERIFY       8

@implementation SelfInfoViewController

@synthesize textBirthday, textEmail, textHomePhone, textIdentityCardNo, textMSN, textName, textNickName, textOfficePhone, textPhone, textQQ, textVerifyCode, datePicker, viewVerifyCode, verifyCodeConstraint, bottomConstraint, buttonUnknown, buttonMale, buttonFemale, labelVerify;

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
    
    self.textBirthday.inputView = self.datePicker;
    self.viewVerifyCode.hidden = YES;
    self.verifyCodeConstraint.constant = VERTICAL_SPACE_WITHOUT_VERIFY;
    
    UIToolbar * topView = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, TEXT_VIEW_ACCESSOR_VIEW_HEIGHT)];
    [topView setBarStyle:UIBarStyleBlackOpaque];
    
    UIBarButtonItem * btnSpace = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    UIBarButtonItem * doneButton = [[UIBarButtonItem alloc]initWithTitle:@"确定" style:UIBarButtonItemStyleDone target:self action:@selector(dismissKeyboard)];
    NSArray * buttonsArray = [NSArray arrayWithObjects:btnSpace,doneButton,nil];
    
    [topView setItems:buttonsArray];
    [self.textBirthday setInputAccessoryView:topView];
    
    [self registerTextField:self.textName];
    [self registerTextField:self.textNickName];
    [self registerTextField:self.textEmail];
    [self registerTextField:self.textPhone];
    [self registerTextField:self.textIdentityCardNo];
    [self registerTextField:self.textBirthday];
    [self registerTextField:self.textMSN];
    [self registerTextField:self.textQQ];
    [self registerTextField:self.textOfficePhone];
    [self registerTextField:self.textHomePhone];
    
    [self sendGetMyInfoRequest];
    
    bottomInitialHeight = self.bottomConstraint.constant;
    // Do any additional setup after loading the view.
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Private Methods
- (void)sendGetMyInfoRequest
{
    infoResponse = nil;
    GetMyInfoRequestParameter *request = [[GetMyInfoRequestParameter alloc] init];
    request.userId = [UserInformation instance].userId;
    request.password = [UserInformation instance].password;
    [[CommunicationManager instance] getMyInfo:request withDelegate:self];
    [[CommonUtilities instance] showNetworkConnecting:self];
}

- (void)sendModifyInfoRequest
{
    BOOL isValid = YES;
    /*
    if([self.textName.text length] == 0){
        isValid = NO;
        [self showErrorMessage:@"请输入真实名字"];
    }
    */
    if([self.textNickName.text length] == 0){
        isValid = NO;
        [self showErrorMessage:@"请输入昵称"];
    }
    else if([self.textEmail.text length] == 0){
        isValid = NO;
        [self showErrorMessage:@"请输入电子邮箱"];
    }
    /*
    else if([self.textQQ.text length] == 0){
        isValid = NO;
        [self showErrorMessage:@"请输入QQ"];
    }
    else if([self.textMSN.text length] == 0){
        isValid = NO;
        [self showErrorMessage:@"请输入MSN"];
    }
    else if([self.textHomePhone.text length] == 0){
        isValid = NO;
        [self showErrorMessage:@"请输入家庭电话"];
    }
    else if([self.textOfficePhone.text length] == 0){
        isValid = NO;
        [self showErrorMessage:@"请输入办公室电话"];
    }
    else if([self.textPhone.text length] != 11){
        isValid = NO;
        [self showErrorMessage:@"请输入手机号码"];
    }
    */
    /*
    else if([self.textIdentityCardNo.text length] != 18){
        isValid = NO;
        [self showErrorMessage:@"请输入身份证号码"];
    }
    */
    else if(![infoResponse.mobilePhone isEqualToString:self.textPhone.text]){
        if([self.textVerifyCode.text length] == 0 || verifyCode == nil){
            isValid = NO;
            [self showErrorMessage:@"请输入验证码"];
        }
        else if(![verifyCode.code isEqualToString:self.textVerifyCode.text]){
            isValid = NO;
            [self showErrorMessage:@"验证码不对"];
        }
        else if([[NSDate date] timeIntervalSinceDate:verifyCodeSendDate] > VERIFY_CODE_VALID_SECONDS ){
            isValid = NO;
            [self showErrorMessage:@"验证码已过期"];
        }
    }
    if(isValid){
        EditMyInfoRequestParameter *request = [[EditMyInfoRequestParameter alloc] init];
        request.userId = [UserInformation instance].userId;
        request.password = [UserInformation instance].password;
        request.realName = self.textName.text;
        request.nickName = self.textNickName.text;
        request.email = self.textEmail.text;
        request.qq = self.textQQ.text;
        request.msn = self.textMSN.text;
        request.homePhone = self.textHomePhone.text;
        request.officePhone = self.textOfficePhone.text;
        request.mobilePhone = self.textPhone.text;
        request.identifyCardNo = self.textIdentityCardNo.text;
        request.birthday = self.textBirthday.text;
        request.sex = infoResponse.sex;
        
        [self resignFocus];
        [[CommunicationManager instance] editMyInfo:request withDelegate:self];
        [[CommonUtilities instance] showNetworkConnecting:self];
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

#pragma mark - Keyboard

- (void)keyboardWillShow
{
    [UIView animateWithDuration:KEYBOARD_ANIMATE_TIME animations:^{
        self.bottomConstraint.constant = bottomInitialHeight + keyboardHeight;
        [self.view layoutIfNeeded];
    } completion:^(BOOL finished) {
        CGPoint newOffset = CGPointMake(0, [CommonHelper getRelatedOriginal:focusController withParent:self.scrollContent].y - self.scrollContent.frame.size.height + focusController.frame.size.height);
        if(newOffset.y > self.scrollContent.contentOffset.y){
            self.scrollContent.contentOffset = newOffset;
        }
    }];
}

- (void)keyboardWillHide
{
    [UIView animateWithDuration:KEYBOARD_ANIMATE_TIME animations:^{
        self.bottomConstraint.constant = bottomInitialHeight;
        [self.view layoutIfNeeded];
    }];
}

#pragma mark - Private Methods

- (void)dismissKeyboard
{
    [self.textBirthday resignFirstResponder];
    infoResponse.birthday = [CommonHelper getDateString:self.datePicker.date];
    self.textBirthday.text = infoResponse.birthday;
}

- (void)updateVerifyStatus:(NSTimer *)timer;
{
    NSDate *currentDate = [NSDate date];
    NSTimeInterval secondsInterval= [currentDate timeIntervalSinceDate:verifyCodeSendDate];
    if(secondsInterval > VERIFY_CODE_VALID_SECONDS){
        self.labelVerify.text = @"获取验证码";
        self.buttonVerifyCode.userInteractionEnabled = YES;
        [verifyTimer invalidate];
    }
    else{
        int remainingSeconds = VERIFY_CODE_VALID_SECONDS - (int)secondsInterval;
        self.labelVerify.text = [NSString stringWithFormat:@"隔%d秒后再试",remainingSeconds];
    }
}

- (void)inputFinish
{
    [super inputFinish];
    [self sendModifyInfoRequest];
}

#pragma mark - Button Actions

- (IBAction)save:(id)sender
{
    [self sendModifyInfoRequest];
}

- (IBAction)sendVerifyCode:(id)sender
{
    self.buttonVerifyCode.userInteractionEnabled = NO;
    [self sendVerifyPhoneRequest];
    //[self sendVerifyCodeRequest];
}

- (IBAction)sexUnknown:(id)sender
{
    if(infoResponse.sex != sexUnknown){
        infoResponse.sex = sexUnknown;
        [self.buttonFemale setSelected:NO];
        [self.buttonMale setSelected:NO];
        [self.buttonUnknown setSelected:YES];
    }
}

- (IBAction)sexMale:(id)sender
{
    if(infoResponse.sex != sexMale){
        infoResponse.sex = sexMale;
        [self.buttonFemale setSelected:NO];
        [self.buttonMale setSelected:YES];
        [self.buttonUnknown setSelected:NO];
    }
}

- (IBAction)sexFemale:(id)sender
{
    if(infoResponse.sex != sexFemale){
        infoResponse.sex = sexFemale;
        [self.buttonFemale setSelected:YES];
        [self.buttonMale setSelected:NO];
        [self.buttonUnknown setSelected:NO];
    }
}

#pragma mark - Text Field Delegate

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    focusController = textField;
    if(textField == self.textBirthday){
        self.datePicker.date = [CommonHelper getDate:infoResponse.birthday];
    }
    if(textField == self.textPhone){
        self.viewVerifyCode.hidden = NO;
        self.verifyCodeConstraint.constant = VERTICAL_SPACE_WITH_VERIFY;
    }
    if(keyboardHeight > 0){
        CGPoint newOffset = CGPointMake(0, [CommonHelper getRelatedOriginal:focusController withParent:self.scrollContent].y - self.scrollContent.frame.size.height + focusController.frame.size.height);
        if(newOffset.y > self.scrollContent.contentOffset.y){
            self.scrollContent.contentOffset = newOffset;
        }
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
    else if([response isKindOfClass:[SendCodeResponseParameter class]]){
        verifyCode = response;
        verifyCodeSendDate = [NSDate date];
        verifyTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(updateVerifyStatus:) userInfo:nil repeats:YES];
    }
    else if([response isKindOfClass:[GetMyInfoResponseParameter class]]){
        infoResponse = response;
        self.textBirthday.text = infoResponse.birthday;
        self.textEmail.text = infoResponse.email;
        self.textHomePhone.text = infoResponse.homePhone;
        self.textIdentityCardNo.text = infoResponse.identifyCardNo;
        self.textMSN.text = infoResponse.msn;
        self.textName.text = infoResponse.realName;
        self.textNickName.text = infoResponse.nickName;
        self.textOfficePhone.text = infoResponse.officePhone;
        self.textPhone.text = infoResponse.mobilePhone;
        self.textQQ.text = infoResponse.qq;
        [self.buttonUnknown setSelected:infoResponse.sex == sexUnknown];
        [self.buttonMale setSelected:infoResponse.sex == sexMale];
        [self.buttonFemale setSelected:infoResponse.sex == sexFemale];
    }
    else{
        [self showErrorMessage:@"修改成功"];
        [self.navigationController popViewControllerAnimated:YES];
        [UserInformation instance].name = self.textNickName.text;
        [[NSUserDefaults standardUserDefaults] setObject:self.textNickName.text forKey:USER_NAME_KEY];
        [[NSUserDefaults standardUserDefaults] setObject:self.textPhone.text forKey:USER_PHONE_KEY];
    }
   
}

- (void)ProcessServerFail:(ServerFailInformation *)failInfo
{
    [[CommonUtilities instance] hideNetworkConnecting];
    [super inputFinish];
    [verifyTimer invalidate];
    self.buttonVerifyCode.userInteractionEnabled = YES;
    NSLog(@"%@",failInfo.message);
    [self showErrorMessage:failInfo.message];
}

- (void)ProcessCommunicationError:(NSError *)error
{
    [[CommonUtilities instance] hideNetworkConnecting];
    [super inputFinish];
    [verifyTimer invalidate];
    self.buttonVerifyCode.userInteractionEnabled = YES;
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

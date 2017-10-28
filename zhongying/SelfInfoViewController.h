//
//  SelfInfoViewController.h
//  zhongying
//
//  Created by lk on 14-4-17.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import "InputViewController.h"
#import "CommunicationManager.h"
#import "CommonEnum.h"
#import "CommunicationManager.h"
#import "GetMyInfoResponseParameter.h"
#import "SendCodeResponseParameter.h"

@interface SelfInfoViewController : InputViewController<CommunicationDelegate>{
    GetMyInfoResponseParameter *infoResponse;
    SendCodeResponseParameter *verifyCode;
    
    NSTimer *verifyTimer;
    NSDate *verifyCodeSendDate;
    
    UIView *focusController;
    float bottomInitialHeight;
}

@property (strong) IBOutlet UITextField *textName;
@property (strong) IBOutlet UITextField *textNickName;
@property (strong) IBOutlet UITextField *textEmail;
@property (strong) IBOutlet UITextField *textPhone;
@property (strong) IBOutlet UITextField *textIdentityCardNo;
@property (strong) IBOutlet UITextField *textBirthday;
@property (strong) IBOutlet UITextField *textMSN;
@property (strong) IBOutlet UITextField *textQQ;
@property (strong) IBOutlet UITextField *textOfficePhone;
@property (strong) IBOutlet UITextField *textHomePhone;
@property (strong) IBOutlet UITextField *textVerifyCode;
@property (strong) IBOutlet UIDatePicker *datePicker;
@property (strong) IBOutlet UIView *viewVerifyCode;

@property (strong) IBOutlet UIButton *buttonUnknown;
@property (strong) IBOutlet UIButton *buttonMale;
@property (strong) IBOutlet UIButton *buttonFemale;

@property (strong) IBOutlet UIButton *buttonVerifyCode;
@property (strong) IBOutlet UILabel *labelVerify;

@property (strong) IBOutlet UIScrollView *scrollContent;

@property (strong) IBOutlet NSLayoutConstraint *verifyCodeConstraint;
@property (strong) IBOutlet NSLayoutConstraint *bottomConstraint;

- (IBAction)sendVerifyCode:(id)sender;
- (IBAction)save:(id)sender;
- (IBAction)sexUnknown:(id)sender;
- (IBAction)sexMale:(id)sender;
- (IBAction)sexFemale:(id)sender;

@end

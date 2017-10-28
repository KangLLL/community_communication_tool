//
//  SigninViewController.h
//  zhongying
//
//  Created by lik on 14-3-19.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import "InputViewController.h"
#import "CommunicationManager.h"

@interface RegisterViewController : InputViewController<CommunicationDelegate>{
    NSString *verifyCode;
    NSTimer *verifyTimer;
    NSDate *verifyCodeSendDate;
}

@property (strong) IBOutlet UITextField *textPhone;
@property (strong) IBOutlet UITextField *textPhoneVerifyCode;
@property (strong) IBOutlet UILabel *labelVerifyTitle;
@property (strong) IBOutlet UIButton *buttonVerify;

- (IBAction)getVerifyCode:(id)sender;
- (IBAction)next:(id)sender;

@end

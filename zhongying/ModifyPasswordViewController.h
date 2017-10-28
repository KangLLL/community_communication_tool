//
//  ModifyPasswordViewController.h
//  zhongying
//
//  Created by lk on 14-4-14.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import "ZhongYingBaseViewController.h"
#import "CommunicationManager.h"

@interface ModifyPasswordViewController : ZhongYingBaseViewController<UITextFieldDelegate, CommunicationDelegate>

@property (strong) IBOutlet UITextField *textOldPassword;
@property (strong) IBOutlet UITextField *textNewPassword;
@property (strong) IBOutlet UITextField *textComfirmPassword;

- (IBAction)modify:(id)sender;

@end

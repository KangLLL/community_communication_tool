//
//  ConfirmPasswordViewController.h
//  zhongying
//
//  Created by lk on 14-4-28.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import "InputViewController.h"
#import "CommunicationManager.h"

@interface ConfirmPasswordViewController : InputViewController<CommunicationDelegate>

@property (strong) IBOutlet UITextField *textPassword;
@property (strong) IBOutlet UITextField *textConfirmPassword;

@property (strong) NSString *phone;
@property (strong) UIViewController *finishController;

- (IBAction)registerUser:(id)sender;

@end

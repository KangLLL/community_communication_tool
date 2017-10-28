//
//  LoginViewController.h
//  zhongying
//
//  Created by lik on 14-3-19.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import "InputViewController.h"
#import "CommunicationDelegate.h"

@interface LoginViewController : InputViewController<CommunicationDelegate>

@property (nonatomic, strong) IBOutlet UITextField *textUserName;
@property (nonatomic, strong) IBOutlet UITextField *textPassword;

- (IBAction)loginTouched:(id)sender;

@end

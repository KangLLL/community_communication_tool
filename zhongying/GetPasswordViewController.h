//
//  GetPasswordViewController.h
//  zhongying
//
//  Created by lik on 14-3-19.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import "InputViewController.h"
#import "CommunicationDelegate.h"

@interface GetPasswordViewController : InputViewController<CommunicationDelegate>

@property (nonatomic, strong) IBOutlet UITextField *textUserName;
@property (nonatomic, strong) IBOutlet UITextField *textEmail;

- (IBAction)getPassword:(id)sender;

@end

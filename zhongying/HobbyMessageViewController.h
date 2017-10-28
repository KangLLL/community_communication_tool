//
//  HobbyMessageViewController.h
//  zhongying
//
//  Created by lik on 14-4-9.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import "InputViewController.h"
#import "HobbyPeopleParameter.h"
#import "CommunicationDelegate.h"
#import "GetHobbyMessageResponseParameter.h"

typedef enum{
    hobbyMessageGet,
    hobbyMessageSend
}HobbyMessageFunction;

@interface HobbyMessageViewController : InputViewController<CommunicationDelegate, UITableViewDataSource, UITableViewDelegate>{
    GetHobbyMessageResponseParameter *messageResponse;
    HobbyMessageFunction currentFunction;
}

@property (strong) IBOutlet UILabel *labelTitle;

@property (strong) IBOutlet NSLayoutConstraint *bottomConstraint;
@property (strong) IBOutlet UITableView *tableContent;
//@property (strong) IBOutlet UITextField *textMessage;
@property (strong) IBOutlet UITextView *textViewMessage;

@property (strong) HobbyPeopleParameter *currentPeople;

- (IBAction)sendMessage:(id)sender;


@end

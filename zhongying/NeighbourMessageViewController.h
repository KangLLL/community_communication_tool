//
//  NeighbourMessageViewController.h
//  zhongying
//
//  Created by lik on 14-4-10.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import "InputViewController.h"
#import "CommunicationDelegate.h"
#import "NeighbourParameter.h"
#import "GetNeighbourMessagesResponseParameter.h"

typedef enum{
    neighbourMessageGet,
    neighbourMessageSend
}NeighbourMessageFunction;


@interface NeighbourMessageViewController : InputViewController<CommunicationDelegate, UITableViewDataSource, UITableViewDelegate>{
    GetNeighbourMessagesResponseParameter *messageResponse;
    NeighbourMessageFunction currentFunction;
}

@property (strong) IBOutlet UILabel *labelTitle;

@property (strong) IBOutlet NSLayoutConstraint *bottomConstraint;
@property (strong) IBOutlet UITableView *tableContent;
//@property (strong) IBOutlet UITextField *textMessage;
@property (strong) IBOutlet UITextView *textViewMessage;

@property (strong) NeighbourParameter *currentNeighbour;

- (IBAction)sendMessage:(id)sender;

@end

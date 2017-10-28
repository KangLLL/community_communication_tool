//
//  AddressesViewController.h
//  zhongying
//
//  Created by lk on 14-4-14.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import "ZhongYingBaseViewController.h"
#import "CommunicationManager.h"
#import "GetAddressesResponseParameter.h"

@interface AddressesViewController : ZhongYingBaseViewController<UITableViewDataSource, UITableViewDelegate, CommunicationDelegate>{
    GetAddressesResponseParameter *currentResponse;
    int currentSelectIndex;
}

@property (strong) IBOutlet UITableView *tableInformations;
@property (assign) BOOL isSelect;
@property (strong) NSString *selectAddressId;

- (IBAction)addAddress:(id)sender;
- (IBAction)editAddress:(id)sender;

@end

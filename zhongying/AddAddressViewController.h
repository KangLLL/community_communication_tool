//
//  AddAddressViewController.h
//  zhongying
//
//  Created by lk on 14-4-14.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import "InputViewController.h"
#import "CommunicationManager.h"
#import "RegionInformation.h"
#import "CommonEnum.h"

@interface AddAddressViewController : InputViewController<CommunicationDelegate, UITableViewDataSource, UITableViewDelegate>{
    AddressSelectType currentSelection;
    UITableView *tableOptions;
    
    RegionInformation *currentProvince;
    RegionInformation *currentCity;
    RegionInformation *currentDistrict;
}

@property (strong) IBOutlet UITextField *textName;
@property (strong) IBOutlet UITextField *textPhone;
@property (strong) IBOutlet UITextField *textAddress;
@property (strong) IBOutlet UITextField *textZipCode;
@property (strong) IBOutlet UITextField *textProvince;
@property (strong) IBOutlet UITextField *textCity;
@property (strong) IBOutlet UITextField *textDistrict;

@property (strong) IBOutlet UIView *viewMask;

- (IBAction)addAddress:(id)sender;

@end

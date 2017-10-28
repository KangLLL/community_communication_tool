//
//  ConfirmOrderViewController.h
//  zhongying
//
//  Created by lk on 14-4-23.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import "ZhongYingBaseViewController.h"
#import "CommunicationManager.h"
#import "ConfirmOrderResponseParameter.h"
#import "AddOrderInformation.h"
#import "CommonEnum.h"
#import "AddressesViewController.h"
#import "AddOrderResponseParameter.h"
#import "GroupViewController.h"

@interface ConfirmOrderViewController : ZhongYingBaseViewController<CommunicationDelegate, UITableViewDataSource, UITableViewDelegate>{
    ConfirmOrderResponseParameter *currentResponse;
    AddOrderResponseParameter *addOrderResponse;
    
    int currentSelectAddressIndex;
    int currentSelectPayIndex;
    int currentSelectShipIndex;
    
    UITableView *tableOptions;
    OrderEditType editType;
    
    AddressesViewController *selectAddressController;
}

@property (strong) IBOutlet UILabel *labelReceiverName;
@property (strong) IBOutlet UILabel *labelPhone;
@property (strong) IBOutlet UILabel *labelAddress;
@property (strong) IBOutlet UILabel *labelPayType;
@property (strong) IBOutlet UILabel *labelPayPrice;
@property (strong) IBOutlet UILabel *labelShipType;
@property (strong) IBOutlet UILabel *labelShipPrice;
@property (strong) IBOutlet UILabel *labelInsurePrice;
@property (strong) IBOutlet UILabel *labelProductName;
@property (strong) IBOutlet UILabel *labelSummaryProductPrice;
@property (strong) IBOutlet UILabel *labelSummaryShipPrice;
@property (strong) IBOutlet UILabel *labelSummaryDiscount;
@property (strong) IBOutlet UILabel *labelOrderPrice;

@property (strong) IBOutlet UIView *viewAttributeParent;
@property (strong) IBOutlet UIView *viewMask;
@property (strong) IBOutlet NSLayoutConstraint *attributeHeight;

@property (strong) GroupViewController *listController;

@property (strong) AddOrderInformation *orderInfo;

- (IBAction)selectPay:(id)sender;
- (IBAction)selectShip:(id)sender;
- (IBAction)selectAddress:(id)sender;
- (IBAction)selectDetail:(id)sender;
- (IBAction)addOrder:(id)sender;

@end

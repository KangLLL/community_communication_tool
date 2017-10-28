//
//  UtilitiesUnpayDetailViewController.h
//  zhongying
//
//  Created by lik on 14-4-1.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import "ZhongYingBaseViewController.h"
#import "UtilitiesParameter.h"
#import "CommunicationDelegate.h"
#import "CommonEnum.h"
#import "StringResponse.h"
#import "UtilitiesDetailResponseParameter.h"
#import "ZhiFuBaoWebViewController.h"
#import "PaymentCenterViewController.h"

@interface UtilitiesUnpayDetailViewController : ZhongYingBaseViewController<CommunicationDelegate, UITableViewDataSource, UITableViewDelegate>{
    StringResponse *payUrl;
    ZhiFuBaoWebViewController *webPayController;
    UtilitiesDetailResponseParameter *currentResponse;
    
    UITableView *tableOptions;
    
    NSInteger currentSelectPayIndex;
}

@property (strong) IBOutlet UILabel *labelCommunityName;
@property (strong) IBOutlet UILabel *labelRoomNo;
@property (strong) IBOutlet UILabel *labelOwnerName;
@property (strong) IBOutlet UILabel *labelValidTime;
@property (strong) IBOutlet UILabel *labelPropertyFee;
@property (strong) IBOutlet UILabel *labelShareFee;
@property (strong) IBOutlet UILabel *labelWaterFee;
@property (strong) IBOutlet UILabel *labelElectricityFee;
@property (strong) IBOutlet UILabel *labelGasFee;
@property (strong) IBOutlet UILabel *labelTotalFee;
@property (strong) IBOutlet UILabel *labelRemainingMoney;

@property (strong) IBOutlet UIView *viewMask;
@property (strong) IBOutlet UILabel *labelPayName;

@property (strong) UtilitiesParameter *utilities;
@property (strong) PaymentCenterViewController *centerController;

- (IBAction)selectPay:(id)sender;

- (IBAction)touchPay:(id)sender;

@end

//
//  ParkingDetailViewController.h
//  zhongying
//
//  Created by lik on 14-4-3.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import "ZhongYingBaseViewController.h"
#import "CommunicationDelegate.h"
#import "ParkingParameter.h"
#import "CommonEnum.h"
#import "StringResponse.h"
#import "ZhiFuBaoWebViewController.h"
#import "ParkingDetailResponseParameter.h"
#import "PaymentCenterViewController.h"

typedef enum{
    parkingSelectRenew,
    parkingSelectPay
}ParkingSelectType;

@interface ParkingDetailViewController : ZhongYingBaseViewController<CommunicationDelegate, UITableViewDataSource, UITableViewDelegate>{
    StringResponse *payUrl;
    NSArray *renewSelections;
    
    ParkingDetailResponseParameter *currentResponse;
    UITableView *tableOptions;
    NSInteger currentSelectPayIndex;
    NSInteger currentRenewSelected;
    
    ParkingSelectType currentType;
    
    ZhiFuBaoWebViewController *webPayController;
}

@property (strong) IBOutlet UILabel *labelCommunityName;
@property (strong) IBOutlet UILabel *labelRoomNo;
@property (strong) IBOutlet UILabel *labelOwnerName;
@property (strong) IBOutlet UILabel *labelBrandName;
@property (strong) IBOutlet UILabel *labelCarNo;
@property (strong) IBOutlet UILabel *labelExpirationTime;
@property (strong) IBOutlet UILabel *labelPrice;
@property (strong) IBOutlet UILabel *labelRenewTime;
@property (strong) IBOutlet UILabel *labelTotalFee;
//@property (strong) IBOutlet UILabel *labelRemainingMoney;


@property (strong) IBOutlet UIView *viewMask;
@property (strong) IBOutlet UILabel *labelPayName;

@property (strong) ParkingParameter *parking;
@property (strong) PaymentCenterViewController *centerController;

- (IBAction)selectRenew:(id)sender;
- (IBAction)selectPay:(id)sender;
- (IBAction)touchPay:(id)sender;

@end

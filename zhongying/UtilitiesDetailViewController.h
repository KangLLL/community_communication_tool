//
//  UtilitiesDetailViewController.h
//  zhongying
//
//  Created by lik on 14-4-1.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import "ZhongYingBaseViewController.h"
#import "CommunicationDelegate.h"
#import "UtilitiesParameter.h"

@interface UtilitiesDetailViewController : ZhongYingBaseViewController<CommunicationDelegate>

@property (strong) IBOutlet UILabel *labelCommunityName;
@property (strong) IBOutlet UILabel *labelRoomNo;
@property (strong) IBOutlet UILabel *labelOwnerName;
@property (strong) IBOutlet UILabel *labelPayerName;
@property (strong) IBOutlet UILabel *labelValidTime;
@property (strong) IBOutlet UILabel *labelPayTime;
@property (strong) IBOutlet UILabel *labelPropertyFee;
@property (strong) IBOutlet UILabel *labelShareFee;
@property (strong) IBOutlet UILabel *labelWaterFee;
@property (strong) IBOutlet UILabel *labelElectricityFee;
@property (strong) IBOutlet UILabel *labelGasFee;
@property (strong) IBOutlet UILabel *labelTotalFee;

@property (strong) UtilitiesParameter *utilities;

@end

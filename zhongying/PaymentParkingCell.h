//
//  PaymentParkingCell.h
//  zhongying
//
//  Created by lik on 14-4-1.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PaymentParkingCell : UITableViewCell

@property (strong) IBOutlet UILabel *labelRoomNo;
@property (strong) IBOutlet UILabel *labelCarNo;
@property (strong) IBOutlet UILabel *labelOwnerName;
@property (strong) IBOutlet UILabel *labelMoney;
@property (strong) IBOutlet UILabel *labelMoneyTitle;
@property (strong) IBOutlet UILabel *labelExpirationTime;
@property (strong) IBOutlet UILabel *labelCardNo;
@property (strong) IBOutlet UIImageView *imageAlreadyPay;
@property (strong) IBOutlet UIImageView *imageUnpay;

@end

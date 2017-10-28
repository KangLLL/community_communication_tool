//
//  PaymentUtilitiesCell.h
//  zhongying
//
//  Created by lik on 14-4-1.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PaymentUtilitiesCell : UITableViewCell

@property (strong) IBOutlet UILabel *labelRoomNo;
@property (strong) IBOutlet UILabel *labelOwnerName;
@property (strong) IBOutlet UILabel *labelTime;
@property (strong) IBOutlet UILabel *labelMoney;
@property (strong) IBOutlet UILabel *labelAlreadyPayTips;
@property (strong) IBOutlet UIButton *buttonPay;
@property (strong) IBOutlet UIButton *buttonDetail;
@property (strong) IBOutlet UIImageView *imageAlreadyPay;
@property (strong) IBOutlet UIImageView *imageUnpay;

@end

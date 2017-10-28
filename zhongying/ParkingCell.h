//
//  ParkingCell.h
//  zhongying
//
//  Created by lik on 14-3-22.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ParkingCell : UITableViewCell

@property (strong) IBOutlet UILabel *labelName;
@property (strong) IBOutlet UILabel *labelRoomNo;
@property (strong) IBOutlet UILabel *labelCarNo;
@property (strong) IBOutlet UILabel *labelCardNo;
@property (strong) IBOutlet UILabel *labelExpiration;
@property (strong) IBOutlet UILabel *labelFee;
@property (strong) IBOutlet UIButton * buttonExpand;

@end

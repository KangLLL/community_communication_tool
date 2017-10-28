//
//  CommunityCell.h
//  zhongying
//
//  Created by lik on 14-3-22.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CommunityCell : UITableViewCell

@property (strong) IBOutlet UILabel *labelName;
@property (strong) IBOutlet UILabel *labelPeopleNumber;
@property (strong) IBOutlet UILabel *labelTwoDimensionCode;

@property (strong) IBOutlet UIButton *buttonDetail;
@property (strong) IBOutlet UIButton *buttonCheckCharge;
@property (strong) IBOutlet UIButton *buttonUnbind;

@end

//
//  RentCell.h
//  zhongying
//
//  Created by lk on 14-4-16.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RentCell : UITableViewCell

@property (strong) IBOutlet UILabel *labelTitle;
@property (strong) IBOutlet UILabel *labelName;
@property (strong) IBOutlet UILabel *labelType;
@property (strong) IBOutlet UILabel *labelMoney;
@property (strong) IBOutlet UILabel *labelTime;

@end
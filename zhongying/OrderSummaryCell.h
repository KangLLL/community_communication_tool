//
//  OrderSummaryCell.h
//  zhongying
//
//  Created by lk on 14-4-23.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderSummaryCell : UITableViewCell

@property (strong) IBOutlet UILabel *labelProductPrice;
@property (strong) IBOutlet UILabel *labelDiscount;
@property (strong) IBOutlet UILabel *labelShipPrice;
@property (strong) IBOutlet UILabel *labelTotal;
@end

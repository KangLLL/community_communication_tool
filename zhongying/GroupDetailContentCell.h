//
//  GroupDetailContentCell.h
//  zhongying
//
//  Created by lk on 14-4-20.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GroupDetailContentCell : UITableViewCell{
    NSTimer *timerCountDown;
    NSDate *dateFinish;
}

@property (strong) IBOutlet UILabel *labelTitle;
@property (strong) IBOutlet UILabel *labelPrice;
@property (strong) IBOutlet UILabel *labelCountDown;
@property (strong) IBOutlet UILabel *labelQuantity;
@property (strong) IBOutlet UILabel *labelRestrict;
@property (strong) IBOutlet UILabel *labelGroupPrice;

@property (strong) IBOutlet UILabel *labelPriceTitle;
@property (strong) IBOutlet UILabel *labelTotalPrice;

@property (strong) IBOutlet UIButton *buttonBuy;

- (void)setFinishTime:(NSDate *)finishTime;
- (void)setInfomation:(NSString *)originalPrice andGroupPrice:(NSString *)groupPrice withDiscount:(NSString *)discount withRestrict:(int)maxRestrict;
- (void)setTotalPrice:(float)totalPrice;
- (void)setGroupPrice:(float)groupPrice;

@end

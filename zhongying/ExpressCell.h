//
//  ExpressCell.h
//  zhongying
//
//  Created by lik on 14-3-22.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ExpressCell : UITableViewCell

@property (strong) IBOutlet UILabel *labelName;
@property (strong) IBOutlet UILabel *labelRoomNo;
@property (strong) IBOutlet UILabel *labelQuantity;
@property (strong) IBOutlet UILabel *labelExpressCorp;
@property (strong) IBOutlet UILabel *labelReceivedTime;
@property (strong) IBOutlet UIButton *buttonGetTime;

@end

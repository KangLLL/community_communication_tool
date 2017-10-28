//
//  PaymentUnreceivedExpressCell.m
//  zhongying
//
//  Created by lik on 14-4-1.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import "PaymentUnreceivedExpressCell.h"

@implementation PaymentUnreceivedExpressCell

@synthesize labelRoomNo, labelOwnerName, labelExpressName, labelArriveTime, labelInformation;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

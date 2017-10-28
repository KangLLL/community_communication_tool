//
//  RentCell.m
//  zhongying
//
//  Created by lk on 14-4-16.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import "RentCell.h"

@implementation RentCell
@synthesize labelMoney, labelName, labelTime, labelTitle, labelType;

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

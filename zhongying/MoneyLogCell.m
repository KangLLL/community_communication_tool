//
//  MoneyLogCell.m
//  zhongying
//
//  Created by lk on 14-4-25.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import "MoneyLogCell.h"

@implementation MoneyLogCell

@synthesize labelMoney, labelTime, labelTips, labelType;

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
    self.layer.borderWidth = 1;
    self.layer.borderColor = [UIColor grayColor].CGColor;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

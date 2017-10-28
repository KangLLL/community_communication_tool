//
//  NeighbourMessageCell.m
//  zhongying
//
//  Created by LI K on 15/4/14.
//  Copyright (c) 2014 lik. All rights reserved.
//

#import "NeighbourMessageCell.h"

@implementation NeighbourMessageCell

@synthesize labelMessage, labelTime, labelName, labelCount;

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

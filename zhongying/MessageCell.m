//
//  MessageCell.m
//  zhongying
//
//  Created by lik on 14-4-11.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import "MessageCell.h"

@implementation MessageCell

@synthesize labelTime, labelName;

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

- (void)setContent:(NSString *)content
{
    
}

- (float)getCellHeight
{
    return 0;
}

@end

//
//  OptionCell.m
//  zhongying
//
//  Created by lik on 14-4-11.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import "OptionCell.h"

#define DEFAULT_TITLE_RECT  CGRectMake(20, 10, 200, 44)

@implementation OptionCell

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

- (void)setOptionString:(NSString *)option withFrame:(CGRect)rect
{
    if(labelOption == nil){
        labelOption = [[UILabel alloc] initWithFrame:rect];
        [self.contentView addSubview:labelOption];
    }
    labelOption.text = option;
    labelOption.backgroundColor = [UIColor clearColor];
}

- (void)setOptionString:(NSString *)option
{
    [self setOptionString:option withFrame:DEFAULT_TITLE_RECT];
}

@end

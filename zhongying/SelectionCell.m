//
//  SelectionCell.m
//  zhongying
//
//  Created by lik on 14-4-7.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import "SelectionCell.h"

#define DEFAULT_IMAGE_RECT  CGRectMake(270, 12, 20, 20)

@implementation SelectionCell

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

    //[self.buttonCheck setSelected:selected];
    
    // Configure the view for the selected state
}

- (void)setOptionString:(NSString *)option withImage:(UIImage *)image
{
    [super setOptionString:option];
    
    if(imageChecked == nil){
        imageChecked = [[UIImageView alloc] initWithFrame:DEFAULT_IMAGE_RECT];
        [self.contentView addSubview:imageChecked];
    }
    imageChecked.image = image;
}

@end

//
//  NotificationContentCell.m
//  zhongying
//
//  Created by lik on 14-4-10.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import "NotificationContentCell.h"

#define CONTENT_START_X         6
#define CONTENT_START_Y         14
#define CONTENT_WIDTH           300
#define CONTENT_BOTTOM_DISTANT  4


@implementation NotificationContentCell

@synthesize imageRead, imageUnread, labelTitle;

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
    self.contentView.backgroundColor = [UIColor lightGrayColor];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setContent:(NSString *)content
{
    if(labelContent == nil){
        labelContent = [[UILabel alloc] init];
    }
    else{
        [labelContent removeFromSuperview];
    }
    UIFont *font = [UIFont systemFontOfSize:10];
    labelContent.font = font;
    labelContent.textColor = [UIColor grayColor];
    labelContent.numberOfLines = 0;
    labelContent.text = content;
    CGSize textSize = [content sizeWithFont:font constrainedToSize:CGSizeMake(CONTENT_WIDTH, 10000) lineBreakMode:NSLineBreakByWordWrapping];
    labelContent.frame = CGRectMake(CONTENT_START_X, CONTENT_START_Y, CONTENT_WIDTH, textSize.height);
    [self.contentView addSubview:labelContent];
    
    CGRect newFrame = self.frame;
    newFrame.size.height = labelContent.frame.origin.y + labelContent.frame.size.height + CONTENT_BOTTOM_DISTANT;
    self.frame = newFrame;
    totalHeight = newFrame.size.height;
}

- (float)getTotalHeight
{
    return totalHeight;
}

+ (float)getCellHeightAccordingToContent:(NSString *)content
{
    UIFont *font = [UIFont systemFontOfSize:10];
    CGSize textSize = [content sizeWithFont:font constrainedToSize:CGSizeMake(CONTENT_WIDTH, 10000) lineBreakMode:NSLineBreakByWordWrapping];
    return CONTENT_START_Y + textSize.height + CONTENT_BOTTOM_DISTANT;
}

@end

//
//  NeighbourOtherCell.m
//  zhongying
//
//  Created by lik on 14-4-11.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import "NeighbourOtherCell.h"

#define BOTTOM_MARGIN           4
#define CONTENT_MARGIN          30
#define CONTENT_START_Y         28
#define CONTENT_WIDTH           200
#define IMAGE_TOP_MARGIN        3
#define IMAGE_BOTTOM_MARGIN     3
#define IMAGE_LEFT_MARGIN       3
#define IMAGE_RIGHT_MARGIN      3

@implementation NeighbourOtherCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setContent:(NSString *)content
{
    if(labelContent != nil){
        [labelContent removeFromSuperview];
        //[viewBackground removeFromSuperview];
    }
    labelContent = [[UILabel alloc] init];
    //viewBackground = [[UIView alloc] init];
    
    labelContent.lineBreakMode = NSLineBreakByWordWrapping;
    labelContent.numberOfLines = 0;
    labelContent.font = [UIFont systemFontOfSize:12];
    labelContent.textAlignment = NSTextAlignmentLeft;
    labelContent.backgroundColor = [UIColor clearColor];
    CGSize textSize = [content sizeWithFont:[UIFont systemFontOfSize:12] constrainedToSize:CGSizeMake(CONTENT_WIDTH,10000) lineBreakMode:NSLineBreakByWordWrapping];
    
    labelContent.frame = CGRectMake(CONTENT_MARGIN, CONTENT_START_Y, CONTENT_WIDTH, textSize.height);
    labelContent.text = content;
    
    //viewBackground.frame = CGRectMake(CONTENT_MARGIN - IMAGE_LEFT_MARGIN, CONTENT_START_Y - IMAGE_TOP_MARGIN, textSize.width + IMAGE_LEFT_MARGIN + IMAGE_RIGHT_MARGIN, labelContent.frame.size.height + IMAGE_TOP_MARGIN + IMAGE_BOTTOM_MARGIN);
    
    //viewBackground.backgroundColor = [UIColor lightGrayColor];
    
    //[self.contentView addSubview:viewBackground];
    [self.contentView addSubview:labelContent];
    
    CGRect newFrame = self.frame;
    newFrame.size.height = CONTENT_START_Y + textSize.height + BOTTOM_MARGIN;
    self.frame = newFrame;
    totalHeight = newFrame.size.height;
}


- (float)getCellHeight
{
    return totalHeight;
}

+ (float)getCellHeightAccordingToContent:(NSString *)content
{
    CGSize textSize = [content sizeWithFont:[UIFont systemFontOfSize:12] constrainedToSize:CGSizeMake(CONTENT_WIDTH,10000) lineBreakMode:NSLineBreakByWordWrapping];
    return CONTENT_START_Y + textSize.height + BOTTOM_MARGIN;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end

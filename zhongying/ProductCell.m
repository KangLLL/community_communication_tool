//
//  ProductCell.m
//  zhongying
//
//  Created by lk on 14-4-24.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import "ProductCell.h"

#define PRODUCT_NAME_TEXT_FORMAT        @"名称：%@"
#define ATTRIBUTE_TEXT_FORMAT           @"属性：%@"
#define QUANTITY_TEXT_FORMAT            @"数量：%@件"
#define ORDER_TYPE_TEXT_FORMAT          @"订单状态：%@"

#define NAME_START_X                    6
#define NAME_START_Y                    6
#define ATTRIBUTE_START_X               6
#define ATTRIBUTE_START_Y               24

#define TEXT_FONT                       [UIFont systemFontOfSize:10]
#define TEXT_HEIGHT                     12

#define TEXT_Y_DISTANT                  6
#define BOTTOM_MARGIN                   6

#define ARROW_IAMGE_NAME                @"Arrow"
#define ARROW_IMAGE_WIDTH               14
#define ARROW_IMAGE_HEIGHT              20
#define ARROW_IMAGE_X                   292


@implementation ProductCell

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


+ (float)getHeight:(ProductParameter *)param withWidth:(float)width
{
    if([param.productAttribute length] > 0){
        NSString *text = [NSString stringWithFormat:ATTRIBUTE_TEXT_FORMAT, param.productAttribute];
        CGSize textSize = [text sizeWithFont:TEXT_FONT constrainedToSize:CGSizeMake(width - 2 * ATTRIBUTE_START_X, 10000) lineBreakMode:NSLineBreakByWordWrapping];
        return ATTRIBUTE_START_Y + textSize.height + BOTTOM_MARGIN + 2 * (TEXT_HEIGHT + TEXT_Y_DISTANT);
    }
    else{
        return NAME_START_Y + TEXT_HEIGHT + BOTTOM_MARGIN + 2 * (TEXT_HEIGHT + TEXT_Y_DISTANT);
    }
}

- (void)setCell:(ProductParameter *)param withOrderType:(NSString *)orderType;
{
    [labelName removeFromSuperview];
    [labelAttribute removeFromSuperview];
    [imageArrow removeFromSuperview];
    [labelOrderType removeFromSuperview];
    [labelQuantity removeFromSuperview];
    
    CGRect newFrame = self.contentView.frame;
    labelName = [[UILabel alloc] initWithFrame:CGRectMake(NAME_START_X, NAME_START_Y, self.contentView.bounds.size.width - 2 * NAME_START_X, TEXT_HEIGHT)];
    labelName.font = TEXT_FONT;
    labelName.text = [NSString stringWithFormat:PRODUCT_NAME_TEXT_FORMAT, param.productName];
    labelName.backgroundColor = [UIColor clearColor];
    
    newFrame.size.height = NAME_START_Y + TEXT_HEIGHT;
    [self.contentView addSubview:labelName];
    
    
    if([param.productAttribute length] > 0){
        float width = self.contentView.bounds.size.width - 2 * ATTRIBUTE_START_X;
        labelAttribute = [[UILabel alloc] init];
        labelAttribute.backgroundColor = [UIColor clearColor];
        labelAttribute.font = TEXT_FONT;
        labelAttribute.numberOfLines = 0;
        labelAttribute.lineBreakMode = NSLineBreakByWordWrapping;
        
        NSString *text = [NSString stringWithFormat:ATTRIBUTE_TEXT_FORMAT, param.productAttribute];
        
        CGSize textSize = [text sizeWithFont:TEXT_FONT constrainedToSize:CGSizeMake(width, 10000) lineBreakMode:NSLineBreakByWordWrapping];
        labelAttribute.text = text;
        labelAttribute.frame = CGRectMake(ATTRIBUTE_START_X, ATTRIBUTE_START_Y, width, textSize.height);
        
        newFrame.size.height = ATTRIBUTE_START_Y + textSize.height;
        [self.contentView addSubview:labelAttribute];
    }
    
    labelQuantity = [[UILabel alloc] initWithFrame:CGRectMake(NAME_START_X, newFrame.size.height + TEXT_Y_DISTANT, self.contentView.bounds.size.width - 2 * NAME_START_X, TEXT_HEIGHT)];
    labelQuantity.backgroundColor = [UIColor clearColor];
    labelQuantity.font = TEXT_FONT;
    labelQuantity.text = [NSString stringWithFormat:QUANTITY_TEXT_FORMAT, param.quantity];
    [self.contentView addSubview:labelQuantity];
    
    newFrame.size.height += TEXT_Y_DISTANT + TEXT_HEIGHT;
    
    labelOrderType = [[UILabel alloc] initWithFrame:CGRectMake(NAME_START_X, newFrame.size.height + TEXT_Y_DISTANT, self.contentView.bounds.size.width - 2 * NAME_START_X, TEXT_HEIGHT)];
    labelOrderType.backgroundColor = [UIColor clearColor];
    labelOrderType.font = TEXT_FONT;
    labelOrderType.text = [NSString stringWithFormat:ORDER_TYPE_TEXT_FORMAT, orderType];
    [self.contentView addSubview:labelOrderType];
    
    newFrame.size.height += TEXT_Y_DISTANT + TEXT_HEIGHT + BOTTOM_MARGIN;
    self.contentView.frame = newFrame;
    
    /*
    imageArrow = [[UIImageView alloc] initWithFrame:CGRectMake(ARROW_IMAGE_X, 0, ARROW_IMAGE_WIDTH, ARROW_IMAGE_HEIGHT)];
    imageArrow.center = CGPointMake(imageArrow.center.x, self.bounds.size.height / 2);
    [imageArrow setImage:[UIImage imageNamed:ARROW_IAMGE_NAME]];
    [self.contentView addSubview:imageArrow];
     */
}

@end

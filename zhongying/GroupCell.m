//
//  GroupCell.m
//  zhongying
//
//  Created by apple on 14-4-13.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import "GroupCell.h"

#define DISCOUNT_DISPLAY_FORMAT         @"%@折"
#define GROUP_PRICE_TITLE               @"优惠价"
#define PRICE_FORMAT                    @"¥%@"
#define GROUP_PRICE_DISPLAY_FORMAT      @"团购价：¥%@"

@implementation GroupCell

@synthesize imagePhoto, labelGroupPrice, labelName, labelOriginalPrice, labelRestrict, activity;

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

- (void)setOriginalPrice:(NSString *)price andGroupPrice:(NSString *)groupPrice forDiscount:(NSString *)discount;
{
    if(labelDiscount == nil){
        labelDiscount = [[UILabel alloc] init];
        labelDiscount.backgroundColor = [UIColor clearColor];
        //labelGroupTitle = [[UILabel alloc] init];
        
        labelDiscount.font = [UIFont systemFontOfSize:11];
        //labelGroupTitle.font = [UIFont systemFontOfSize:11];
        //labelGroupTitle.textColor = [UIColor redColor];
        [self.contentView addSubview:labelDiscount];
    }
    
    NSString *plainText = price;
    NSDictionary *attributes = @{NSStrikethroughStyleAttributeName: [NSNumber numberWithInt:1]};
    NSRange range = [plainText rangeOfString:plainText];
    NSMutableAttributedString *styledText = [[NSMutableAttributedString alloc] initWithString:plainText];
    [styledText setAttributes:attributes range:range];
    self.labelOriginalPrice.attributedText = styledText;
    
    CGSize textSize = [styledText size];
    
    CGRect frame = CGRectMake(self.labelOriginalPrice.frame.origin.x + textSize.width + 3, self.labelOriginalPrice.frame.origin.y, 200, self.labelOriginalPrice.frame.size.height);
    
    labelDiscount.frame = frame;
    self.labelOriginalPrice.attributedText = styledText;
    labelDiscount.text = [NSString stringWithFormat:DISCOUNT_DISPLAY_FORMAT, discount];
    
    plainText = [NSString stringWithFormat:GROUP_PRICE_DISPLAY_FORMAT, groupPrice];
    styledText = [[NSMutableAttributedString alloc] initWithString:plainText];
    attributes = @{NSFontAttributeName : [UIFont systemFontOfSize:11]};
    range = [plainText rangeOfString:GROUP_PRICE_TITLE];
    [styledText setAttributes:attributes range:range];
    
    attributes = @{NSFontAttributeName : [UIFont systemFontOfSize:13]};
    range = [plainText rangeOfString:[NSString stringWithFormat:PRICE_FORMAT, groupPrice]];
    [styledText addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:13] range:range];
    self.labelGroupPrice.attributedText = styledText;
}

@end

//
//  MyRentCell.m
//  zhongying
//
//  Created by lk on 14-4-16.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import "MyRentCell.h"

@implementation MyRentCell

@synthesize labelType, labelTitle, labelTime, labelMoney;

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
    NSString *plainText = self.buttonEdit.titleLabel.text;
    NSMutableAttributedString *styledText = [[NSMutableAttributedString alloc] initWithString:plainText];
    
    NSDictionary *attributes = @{NSUnderlineStyleAttributeName : [NSNumber numberWithInt:1]};
    NSRange range = [plainText rangeOfString:plainText];
    [styledText setAttributes:attributes range:range];
    self.buttonEdit.titleLabel.attributedText = styledText;
    
    plainText = self.buttonDelete.titleLabel.text;
    styledText = [[NSMutableAttributedString alloc] initWithString:plainText];
    
    attributes = @{NSUnderlineStyleAttributeName : [NSNumber numberWithInt:1]};
    range = [plainText rangeOfString:plainText];
    [styledText setAttributes:attributes range:range];
    self.buttonDelete.titleLabel.attributedText = styledText;

    
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

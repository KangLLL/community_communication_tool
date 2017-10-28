//
//  GroupDetailContentCell.m
//  zhongying
//
//  Created by lk on 14-4-20.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import "GroupDetailContentCell.h"
#import "CommonHelper.h"


#define COUNT_DOWN_TEXT_FORMAT          @"距离结束时间  %@"
#define COUNT_DOWN_FINISH_TEXT          @"活动已结束"
#define PRICE_FORMAT                    @"原价:%@ %@折 节省¥%.2f"
#define RESTRICT_FORMAT                 @"每人限购%d件"
#define TOTAL_PRICE_FORMAT              @"总价:¥%.2f"


@interface GroupDetailContentCell()

- (void)updateCountDownLabel;

@end

@implementation GroupDetailContentCell

@synthesize labelCountDown, labelGroupPrice, labelPrice, labelQuantity, labelRestrict, labelTitle, buttonBuy, labelPriceTitle, labelTotalPrice;

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

- (void)setFinishTime:(NSDate *)finishTime
{
    dateFinish = finishTime;
    [timerCountDown invalidate];
    timerCountDown = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(updateCountDownLabel) userInfo:nil repeats:YES];
    [self updateCountDownLabel];
}


- (void)setInfomation:(NSString *)originalPrice andGroupPrice:(NSString *)groupPrice withDiscount:(NSString *)discount withRestrict:(int)maxRestrict
{
    
    NSString *plainText = [NSString stringWithFormat:PRICE_FORMAT,originalPrice, discount, [originalPrice floatValue] - [groupPrice floatValue]];
    NSMutableAttributedString *styledText = [[NSMutableAttributedString alloc] initWithString:plainText];
    NSDictionary *attributes = @{NSForegroundColorAttributeName : [UIColor blackColor]};
    NSRange range = [plainText rangeOfString:[NSString stringWithFormat:@"%@折",discount]];
    [styledText setAttributes:attributes range:range];
    
    range = [plainText rangeOfString:[NSString stringWithFormat:@"原价:%@", originalPrice]];
    [styledText addAttribute:NSStrikethroughStyleAttributeName value:[NSNumber numberWithInt:1] range:range];

    self.labelPrice.attributedText = styledText;
    
    self.labelRestrict.text = [NSString stringWithFormat:RESTRICT_FORMAT, maxRestrict];
    self.labelQuantity.text = @"1";
    self.labelGroupPrice.text = [NSString stringWithFormat:@"%@", groupPrice];
    [self setTotalPrice:[groupPrice floatValue]];
}

- (void)setGroupPrice:(float)groupPrice
{
    self.labelGroupPrice.text = [NSString stringWithFormat:@"%.2f", groupPrice];
}

- (void)setTotalPrice:(float)totalPrice
{
    NSString *plainText = [NSString stringWithFormat:TOTAL_PRICE_FORMAT, totalPrice];
    NSMutableAttributedString *styledText = [[NSMutableAttributedString alloc] initWithString:plainText];
    NSDictionary *attributes = @{NSForegroundColorAttributeName : [UIColor orangeColor]};
    NSRange range = [plainText rangeOfString:[NSString stringWithFormat:@"%.2f", totalPrice]];
    [styledText setAttributes:attributes range:range];
    self.labelTotalPrice.attributedText = styledText;
}

- (void)updateCountDownLabel
{
    NSString *remainingTime = [CommonHelper getCountDownStringToDate:dateFinish];
    if(remainingTime != nil){
        self.labelCountDown.text = [NSString stringWithFormat:COUNT_DOWN_TEXT_FORMAT,remainingTime];
    }
    else{
        self.labelCountDown.text = COUNT_DOWN_FINISH_TEXT;
        self.buttonBuy.hidden = YES;
        [timerCountDown invalidate];
    }
}

@end

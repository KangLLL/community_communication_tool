//
//  ProductCellView.m
//  zhongying
//
//  Created by lk on 14-4-24.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import "ProductCellView.h"

#define PRODUCT_NAME_TEXT_FORMAT        @"名称：%@"
#define ATTRIBUTE_TEXT_FORMAT           @"属性：%@"

#define NAME_START_X                    6
#define NAME_START_Y                    6
#define ATTRIBUTE_START_X               6
#define ATTRIBUTE_START_Y               24

#define TEXT_FONT                       [UIFont systemFontOfSize:10]
#define TEXT_HEIGHT                     12

#define BOTTOM_MARGIN                   6

#define ARROW_IAMGE_NAME                @"Arrow"
#define ARROW_IMAGE_WIDTH               14
#define ARROW_IMAGE_HEIGHT              20
#define ARROW_IMAGE_X                   292

@implementation ProductCellView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

+ (float)getHeight:(ProductParameter *)param withWidth:(float)width
{
    if([param.productAttribute length] > 0){
        NSString *text = [NSString stringWithFormat:ATTRIBUTE_TEXT_FORMAT, param.productAttribute];
        CGSize textSize = [text sizeWithFont:TEXT_FONT constrainedToSize:CGSizeMake(width - 2 * ATTRIBUTE_START_X, 10000) lineBreakMode:NSLineBreakByWordWrapping];
        return ATTRIBUTE_START_Y + textSize.height + BOTTOM_MARGIN;
    }
    else{
        return NAME_START_Y + TEXT_HEIGHT + BOTTOM_MARGIN;
    }
}

- (float)setCell:(ProductParameter *)param withButtonTarget:(id)target andSelector:(SEL)selector;
{
    CGRect newFrame = self.frame;
    UILabel *labelName = [[UILabel alloc] initWithFrame:CGRectMake(NAME_START_X, NAME_START_Y, self.bounds.size.width - 2 * NAME_START_X, TEXT_HEIGHT)];
    labelName.font = TEXT_FONT;
    labelName.text = [NSString stringWithFormat:PRODUCT_NAME_TEXT_FORMAT, param.productName];
    
    newFrame.size.height = NAME_START_Y + TEXT_HEIGHT + BOTTOM_MARGIN;
    [self addSubview:labelName];

    
    if([param.productAttribute length] > 0){
        float width = self.bounds.size.width - 2 * ATTRIBUTE_START_X;
        UILabel *labelAttribute = [[UILabel alloc] init];
        labelAttribute.font = TEXT_FONT;
        labelAttribute.numberOfLines = 0;
        labelAttribute.lineBreakMode = NSLineBreakByWordWrapping;
        
        NSString *text = [NSString stringWithFormat:ATTRIBUTE_TEXT_FORMAT, param.productAttribute];
        
        CGSize textSize = [text sizeWithFont:TEXT_FONT constrainedToSize:CGSizeMake(width, 10000) lineBreakMode:NSLineBreakByWordWrapping];
        labelAttribute.text = text;
        labelAttribute.frame = CGRectMake(ATTRIBUTE_START_X, ATTRIBUTE_START_Y, width, textSize.height);
        
        newFrame.size.height = ATTRIBUTE_START_Y + textSize.height + BOTTOM_MARGIN;
        [self addSubview:labelAttribute];
    }
    self.frame = newFrame;
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height);
    [button addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    
    UIImageView *imageArrow = [[UIImageView alloc] initWithFrame:CGRectMake(ARROW_IMAGE_X, 0, ARROW_IMAGE_WIDTH, ARROW_IMAGE_HEIGHT)];
    imageArrow.center = CGPointMake(imageArrow.center.x, self.bounds.size.height / 2);
    [imageArrow setImage:[UIImage imageNamed:ARROW_IAMGE_NAME]];
    [self addSubview:imageArrow];
    
    self.backgroundColor = [UIColor lightGrayColor];
    
    return newFrame.size.height;
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

//
//  ProductsView.m
//  zhongying
//
//  Created by lk on 14-4-24.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import "ProductsView.h"
#import "ProductCellView.h"
#import "ProductParameter.h"

#define CELL_Y_DISTANT          6

@interface ProductsView()
- (void)touchProduct:(id)sender;
@end

@implementation ProductsView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (float)setView:(NSArray *)products
{
    CGRect newFrame = self.frame;
    float totalY = 0;
    for (int i = 0; i < [products count]; i ++) {
        if(totalY > 0){
            totalY += CELL_Y_DISTANT;
        }
        ProductParameter *param = [products objectAtIndex:i];
        ProductCellView *cell = [[ProductCellView alloc] initWithFrame:CGRectMake(0, totalY, self.bounds.size.width, 0)];
        cell.tag = i;
        float cellHeight = [cell setCell:param withButtonTarget:self andSelector:@selector(touchProduct:)];
        [self addSubview:cell];
        totalY += cellHeight;
    }
    newFrame.size.height = totalY;
    return totalY;
}

+ (float)getHeight:(NSArray *)products withWidth:(float)width
{
    float totalY = 0;
    for (int i = 0; i < [products count]; i ++) {
        if(totalY > 0){
            totalY += CELL_Y_DISTANT;
        }
        ProductParameter *param = [products objectAtIndex:i];
        totalY += [ProductCellView getHeight:param withWidth:width];
    }
    return totalY;
}

- (void)touchProduct:(id)sender
{
    UIButton *button = (UIButton *)sender;
    if(self.delegate != nil){
        [self.delegate productsView:self touchProductAtIndex:button.tag];
    }
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

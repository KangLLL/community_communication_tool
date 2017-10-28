//
//  SelectFoldableView.m
//  zhongying
//
//  Created by lik on 14-3-29.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import "SelectFoldableView.h"

@interface SelectFoldableView()

@end

@implementation SelectFoldableView
@synthesize selectItemImage, unselectItemImage;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)reloadData
{
    [super reloadData];
    buttons = [NSMutableDictionary dictionary];
    for (UIView *container in items) {
        for (UIView *button in container.subviews) {
            if([button isKindOfClass:[UIButton class]]){
                UIButton *b = (UIButton *)button;
                [b setBackgroundImage:self.unselectItemImage forState:UIControlStateNormal];
                [b setBackgroundImage:self.selectItemImage forState:UIControlStateSelected];
                [buttons setObject:b forKey:[NSNumber numberWithInt:container.tag]];
            }
        }
    }
   
    selectIndex = -1;
    
    /*
    if([items count] > 0){
        [self setSelectIndex:0];
    }
     */
}

- (void)touchItem:(id)sender
{
    UIButton *button = (UIButton *)sender;
    int index = button.tag;
    if(index != selectIndex){
        [super touchItem:sender];
        [self setSelectIndex:index];
    }
}

- (int)getSelectIndex
{
    return selectIndex;
}

- (void)setSelectIndex:(int)index
{
    if(index >= 0 && index < [items count]){
        UIButton *button = [buttons objectForKey:[NSNumber numberWithInt:index]];
        [button setSelected:YES];
        if(selectIndex >= 0 && selectIndex != index)
        {
            button = [buttons objectForKey:[NSNumber numberWithInt:selectIndex]];
            [button setSelected:NO];
        }
        selectIndex = index;
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

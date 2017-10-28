//
//  MultiplySelectPopupView.m
//  zhongying
//
//  Created by LI K on 8/4/14.
//  Copyright (c) 2014 lik. All rights reserved.
//

#import "MultiplySelectPopupView.h"

@implementation MultiplySelectPopupView

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
    options = [NSMutableDictionary dictionary];
    self.selections = [NSMutableArray array];
    if(self.imageFrame.size.width > 0 && self.imageFrame.size.height > 0){
        for (UIView *item in items) {
            UIButton *button = [[UIButton alloc] initWithFrame:self.imageFrame];
            [button setBackgroundImage:self.selectImage forState:UIControlStateSelected];
            [button setBackgroundImage:self.unselectImage forState:UIControlStateNormal];
            button.userInteractionEnabled = NO;
            [item addSubview:button];
            [options setObject:button forKey:[NSNumber numberWithInt:item.tag]];
        }
    }
}

- (void)touchItem:(id)sender
{
    int touchedIndex = ((UIButton *)sender).tag;
    if([self.selections containsObject:[NSNumber numberWithInt:touchedIndex]]){
        UIButton *button = [options objectForKey:[NSNumber numberWithInt:touchedIndex]];
        [button setSelected:NO];
        
        [self.selections removeObject:[NSNumber numberWithInt:touchedIndex]];
    }
    else{
        UIButton *button = [options objectForKey:[NSNumber numberWithInt:touchedIndex]];
        [button setSelected:YES];
        
        [self.selections addObject:[NSNumber numberWithInt:touchedIndex]];
    }
    [super touchItem:sender];
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

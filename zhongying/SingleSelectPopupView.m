//
//  SelectPopupView.m
//  zhongying
//
//  Created by LI K on 8/4/14.
//  Copyright (c) 2014 lik. All rights reserved.
//

#import "SingleSelectPopupView.h"

@implementation SingleSelectPopupView

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
    if(self.imageFrame.size.width > 0 && self.imageFrame.size.height){
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
    
    if(self.selectIndex != touchedIndex){
        UIButton *button = [options objectForKey:[NSNumber numberWithInt:self.selectIndex]];
        [button setSelected:NO];
        
        self.selectIndex = touchedIndex;
        button = [options objectForKey:[NSNumber numberWithInt:self.selectIndex]];
        [button setSelected:YES];
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

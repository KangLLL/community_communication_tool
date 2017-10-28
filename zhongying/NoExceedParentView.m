//
//  NoExceedParentView.m
//  zhongying
//
//  Created by lik on 14-4-4.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import "NoExceedParentView.h"

@implementation NoExceedParentView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    for (UIView *child in self.subviews) {
        if(child.frame.origin.y + child.frame.size.height > self.bounds.size.height){
            child.frame = CGRectMake(child.frame.origin.x, child.frame.origin.y, child.frame.size.width, self.bounds.size.height - child.frame.origin.y);
        }
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

//
//  EditFoldableView.m
//  zhongying
//
//  Created by lik on 14-4-9.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import "EditFoldableView.h"

@interface EditFoldableView()
- (void)longTouch:(UILongPressGestureRecognizer *)sender;
//- (void)refresh;
@end

@implementation EditFoldableView

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
    
    tipsButton = [NSMutableDictionary dictionary];
    self.selections = [NSMutableArray array];
    
    for (UIView *container in items) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = self.imageFrame;
        button.userInteractionEnabled = NO;
        [button setBackgroundImage:self.imageUnselect forState:UIControlStateNormal];
        [button setBackgroundImage:self.imageSelect forState:UIControlStateSelected];
        button.tag = container.tag;
        [container addSubview:button];
        [tipsButton setObject:button forKey:[NSNumber numberWithInt:button.tag]];
        
        button.hidden = YES;
    }
    
    for (UIButton *button in [buttons allValues]) {
        UILongPressGestureRecognizer *gr = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longTouch:)];
        [button addGestureRecognizer:gr];
    }
    self.editType = editSingle;
}


- (void)touchItem:(id)sender
{
    if(self.editType == editSingle){
        [super touchItem:sender];
    }
    else{
        UIButton *button = (UIButton *)sender;
        NSNumber *number = [NSNumber numberWithInt:button.tag];
        if([self.selections containsObject:number]){
            [self.selections removeObject:number];
            UIButton *tb = [tipsButton objectForKey:number];
            [tb setSelected:NO];
        }
        else{
            [self.selections addObject:number];
            UIButton *tb = [tipsButton objectForKey:number];
            [tb setSelected:YES];
        }
    }
}

#pragma mark - Public Methods
- (void)changeState
{
    if(self.editType == editSingle){
        self.editType = editMultiplay;
        for (UIButton *tips in [tipsButton allValues]) {
            tips.hidden = NO;
        }
        [self.selections removeAllObjects];
    }
    else{
        self.editType = editSingle;
        for (UIButton *tb in [tipsButton allValues]) {
            tb.hidden = YES;
            [tb setSelected:NO];
        }
    }
    
    if(self.delegate != nil && [self.delegate respondsToSelector:@selector(editFoldableView:changeToState:)]){
        [self.delegate editFoldableView:self changeToState:self.editType];
    }
}

#pragma mark - Private Methods

- (void)longTouch:(UILongPressGestureRecognizer *)sender
{
    if(sender.state == UIGestureRecognizerStateBegan){
        [self changeState];
    }
}

/*
- (void)refresh
{
    if(self.editType == editSingle){
        self.editType = editMultiplay;
        for (UIButton *tips in [tipsButton allValues]) {
            tips.hidden = NO;
        }
        [self.selections removeAllObjects];
    }
    else{
        self.editType = editSingle;
        for (UIButton *tb in [tipsButton allValues]) {
            tb.hidden = YES;
            [tb setSelected:NO];
        }
    }
    
    if(self.delegate != nil && [self.delegate respondsToSelector:@selector(editFoldableView:changeToState:)]){
        [self.delegate editFoldableView:self changeToState:self.editType];
    }
}
*/
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end

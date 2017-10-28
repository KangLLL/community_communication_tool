//
//  FoldableView.m
//  zhongying
//
//  Created by lik on 14-3-29.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import "FoldableView.h"

#define DEFAULT_FOLD_ROW            1
#define DEFAULT_HEIGHT_OF_ITEM      26
#define DEFAULT_WIDTH_OF_ITEM       100
#define DEFAULT_ROW_DISTANCE        5
#define DEFAULT_COLUMN_DISTANCE     6
#define DEFAULT_MARGIN_TOP          8
#define DEFAULT_MARGIN_BOTTOM       8
#define DEFAULT_MARGIN_LEFT         4
#define DEFAULT_MARGIN_RIGHT        4
#define DEFAULT_ANIMATION_TIME      0.5

@implementation FoldableView

@synthesize dataDelegate,delegate,heightConstraint;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        items = [NSMutableArray array];
    }
    return self;
}

- (id)init
{
    self = [super init];
    if(self){
        items = [NSMutableArray array];
        isFold = YES;
    }
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if(self){
        items = [NSMutableArray array];
        isFold = YES;
    }
    return self;
}

#pragma mark Public Methods
- (BOOL)isFolded
{
    return isFold;
}

- (void)reloadData
{
    for (UIButton *button in items) {
        [button removeFromSuperview];
    }
    [items removeAllObjects];
    
    foldRow = self.delegate != nil && [self.delegate respondsToSelector:@selector(numberOfRowInFold)] ? [self.delegate numberOfRowInFold] : DEFAULT_FOLD_ROW;
    heightOfItem = self.delegate != nil && [self.delegate respondsToSelector:@selector(heightOfItemInView)] ? [self.delegate heightOfItemInView] : DEFAULT_HEIGHT_OF_ITEM;
    widthOfItem = self.delegate != nil && [self.delegate respondsToSelector:@selector(widthOfItemInView)] ? [self.delegate widthOfItemInView] : DEFAULT_WIDTH_OF_ITEM;
    rowDistance = self.delegate != nil && [self.delegate respondsToSelector:@selector(rowDistance)] ? [self.delegate rowDistance] : DEFAULT_ROW_DISTANCE;
    columnDistance = self.delegate != nil && [self.delegate respondsToSelector:@selector(columnDistance)] ? [self.delegate columnDistance] : DEFAULT_COLUMN_DISTANCE;
    
    marginTop = self.delegate != nil && [self.delegate respondsToSelector:@selector(marginOfTopInView)] ? [self.delegate marginOfTopInView] : DEFAULT_MARGIN_TOP;
    marginBottom = self.delegate != nil && [self.delegate respondsToSelector:@selector(marginOfBottomInView)] ? [self.delegate marginOfBottomInView] : DEFAULT_MARGIN_BOTTOM;
    marginLeft = self.delegate != nil && [self.delegate respondsToSelector:@selector(marginOfLeftInView)] ? [self.delegate marginOfLeftInView] : DEFAULT_MARGIN_LEFT;
    marginRight = self.delegate != nil && [self.delegate respondsToSelector:@selector(marginOfRightInView)] ? [self.delegate marginOfRightInView] : DEFAULT_MARGIN_RIGHT;
    
    animationTime = self.delegate != nil && [self.delegate respondsToSelector:@selector(foldAnimationTime)] ? [self.delegate foldAnimationTime] : DEFAULT_ANIMATION_TIME;
    
    numberOfItemPerRow = (int)((self.bounds.size.width - marginLeft - marginRight - widthOfItem) / (widthOfItem + columnDistance)) + 1;
    //NSLog(@"%d",[self.dataDelegate numberOfItemInView]);
    totalRows = [self.dataDelegate numberOfItemInView] % numberOfItemPerRow == 0 ? [self.dataDelegate numberOfItemInView] / numberOfItemPerRow : [self.dataDelegate numberOfItemInView] / numberOfItemPerRow + 1;
    
    for(int i = 0; i < [self.dataDelegate numberOfItemInView]; i ++){
        int row = i / numberOfItemPerRow;
        int column = i % numberOfItemPerRow;
        
        float x = marginLeft + column * (widthOfItem + columnDistance);
        float y = marginTop + row * (heightOfItem + rowDistance);
        
        UIView *container = [[UIView alloc] initWithFrame:CGRectMake(x, y, widthOfItem, heightOfItem)];
        container.tag = i;
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(0, 0, widthOfItem, heightOfItem);
    
        button.tag = i;
        
        UILabel *labelTitle = [[UILabel alloc] initWithFrame:button.frame];
        labelTitle.backgroundColor = [UIColor clearColor];
        labelTitle.font = [UIFont systemFontOfSize:13];
        labelTitle.textColor = [UIColor blackColor];
        labelTitle.textAlignment = NSTextAlignmentCenter;
        labelTitle.minimumScaleFactor = 0.5f;
        labelTitle.text = [self.dataDelegate foldableView:self titleAtIndex:i];
        /*
        button.titleLabel.minimumScaleFactor = 0.5f;
        [button setTitle:[self.dataDelegate foldableView:self titleAtIndex:i] forState:UIControlStateNormal];
         */
        [button addTarget:self action:@selector(touchItem:) forControlEvents:UIControlEventTouchUpInside];
        
        [container addSubview:button];
        [container addSubview:labelTitle];
        if(!isFold || row < foldRow){
            [self addSubview:container];
        }
        [items addObject:container];
    }
    
    float totalHeight = isFold ? marginTop + marginBottom + heightOfItem + (MIN(foldRow,totalRows) - 1) * (heightOfItem + rowDistance): marginTop + marginBottom + heightOfItem + (totalRows - 1) * (heightOfItem + rowDistance);
    
    
    UIView *topView = self.superview;
    while (topView != nil && ![topView isKindOfClass:[UIWindow class]]) {
        topView = topView.superview;
    }
    [topView layoutIfNeeded];
    //[self.superview layoutIfNeeded];
    //self.heightConstraint.constant = totalHeight;
    //[self.superview layoutIfNeeded];
    
    
    [UIView animateWithDuration:animationTime animations:^{
        self.heightConstraint.constant = totalHeight;
        //[self.superview layoutIfNeeded];
        [topView layoutIfNeeded];
    } completion:^(BOOL finished) {
        if(self.delegate != nil && [self.delegate respondsToSelector:@selector(animationFinished:)]){
            [self.delegate animationFinished:finished];
        }
    }];
    
}

- (void)foldView
{
    if(!isFold){
        if(foldRow < totalRows){
            int removeStartIndex = foldRow * numberOfItemPerRow;
            
            for(int i = removeStartIndex; i < [items count]; i ++){
                UIButton *item = [items objectAtIndex:i];
                [item removeFromSuperview];
            }
            
            float totalHeight = marginTop + marginBottom + heightOfItem + (MIN(foldRow,totalRows) - 1) * (heightOfItem + rowDistance);
            
            UIView *topView = self.superview;
            while (topView != nil && ![topView isKindOfClass:[UIWindow class]]) {
                topView = topView.superview;
            }
            //[self.superview layoutIfNeeded];
            [topView layoutIfNeeded];
            [UIView animateWithDuration:animationTime animations:^{
                self.heightConstraint.constant = totalHeight;
                //[self.superview layoutIfNeeded];
                [topView layoutIfNeeded];
            } completion:^(BOOL finished) {
                if(self.delegate != nil && [self.delegate respondsToSelector:@selector(animationFinished:)]){
                    [self.delegate animationFinished:finished];
                }
            }];
        }
        isFold = true;
    }
}

- (void)unfoldView
{
    if(isFold){
        if(foldRow < totalRows){
            int addStartIndex = foldRow * numberOfItemPerRow;
            
            for(int i = addStartIndex; i < [items count]; i ++){
                UIButton *item = [items objectAtIndex:i];
                [self addSubview:item];
            }
            
            float totalHeight = marginTop + marginBottom + heightOfItem + (totalRows - 1) * (heightOfItem + rowDistance);
            
            UIView *topView = self.superview;
            while (topView != nil && ![topView isKindOfClass:[UIWindow class]]) {
                topView = topView.superview;
            }
            //[self.superview layoutIfNeeded];
            [topView layoutIfNeeded];
            [UIView animateWithDuration:animationTime animations:^{
                self.heightConstraint.constant = totalHeight;
                //[self.superview layoutIfNeeded];
                [topView layoutIfNeeded];
            } completion:^(BOOL finished) {
                if(self.delegate != nil && [self.delegate respondsToSelector:@selector(animationFinished:)]){
                    [self.delegate animationFinished:finished];
                }
            }];
        }
        isFold = false;
    }
}

#pragma mark - Private Methods

- (void)touchItem:(id)sender
{
    UIButton *button = (UIButton *)sender;
    if(self.delegate != nil && [self.delegate respondsToSelector:@selector(foldableView:didSelectAtIndex:)]){
        int index = (int)button.tag;
        [self.delegate foldableView:self didSelectAtIndex:index];
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

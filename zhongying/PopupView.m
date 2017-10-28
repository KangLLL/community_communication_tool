//
//  PopupView.m
//  zhongying
//
//  Created by LI K on 8/4/14.
//  Copyright (c) 2014 lik. All rights reserved.
//

#import "PopupView.h"

#define DEFAULT_HEAD_HEIGHT         20
#define DEFAULT_FOOT_HEIGHT         30
#define DEFAULT_MAX_HEIGHT          300
#define DEFAULT_HEIGHT_OF_ITEM      26
#define DEFAULT_WIDTH_OF_ITEM       100
#define DEFAULT_ROW_DISTANCE        5
#define DEFAULT_COLUMN_DISTANCE     6
#define DEFAULT_MARGIN_TOP          8
#define DEFAULT_MARGIN_BOTTOM       8
#define DEFAULT_MARGIN_LEFT         4
#define DEFAULT_MARGIN_RIGHT        4
#define DEFAULT_WIDTH_OF_CONTENT    300
#define DEFAULT_ANIMATION_TIME      0.5
#define DEFAULT_TITLE_OFFSET        CGPointZero

@implementation PopupView

@synthesize dataDelegate,delegate;

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
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if(self){
        items = [NSMutableArray array];
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}


- (void)reloadData
{
    for (UIButton *button in items) {
        [button removeFromSuperview];
    }
    [items removeAllObjects];
    
    [headView removeFromSuperview];
    [footView removeFromSuperview];
    [contentView removeFromSuperview];
    headView = nil;
    footView = nil;
    contentView = nil;
    
    heightOfItem = self.delegate != nil && [self.delegate respondsToSelector:@selector(heightOfItemInPopupView:)] ? [self.delegate heightOfItemInPopupView:self] : DEFAULT_HEIGHT_OF_ITEM;
    widthOfItem = self.delegate != nil && [self.delegate respondsToSelector:@selector(widthOfItemInPopupView:)] ? [self.delegate widthOfItemInPopupView:self] : DEFAULT_WIDTH_OF_ITEM;
    rowDistance = self.delegate != nil && [self.delegate respondsToSelector:@selector(rowDistanceInPopupView:)] ? [self.delegate rowDistanceInPopupView:self] : DEFAULT_ROW_DISTANCE;
    columnDistance = self.delegate != nil && [self.delegate respondsToSelector:@selector(columnDistanceInPopupView:)] ? [self.delegate columnDistanceInPopupView:self] : DEFAULT_COLUMN_DISTANCE;
    
    marginTop = self.delegate != nil && [self.delegate respondsToSelector:@selector(marginOfTopInPopupView:)] ? [self.delegate marginOfTopInPopupView:self] : DEFAULT_MARGIN_TOP;
    marginBottom = self.delegate != nil && [self.delegate respondsToSelector:@selector(marginOfBottomInPopupView:)] ? [self.delegate marginOfBottomInPopupView:self] : DEFAULT_MARGIN_BOTTOM;
    marginLeft = self.delegate != nil && [self.delegate respondsToSelector:@selector(marginOfLeftInPopupView:)] ? [self.delegate marginOfLeftInPopupView:self] : DEFAULT_MARGIN_LEFT;
    marginRight = self.delegate != nil && [self.delegate respondsToSelector:@selector(marginOfRightInPopupView:)] ? [self.delegate marginOfRightInPopupView:self] : DEFAULT_MARGIN_RIGHT;
    
    heightOfHead = self.delegate != nil && [self.delegate respondsToSelector:@selector(heightOfHeadInPopupView:)] ? [self.delegate heightOfHeadInPopupView:self] : DEFAULT_HEAD_HEIGHT;
    heightOfFoot = self.delegate != nil && [self.delegate respondsToSelector:@selector(heightOfFootInPopupView:)] ? [self.delegate heightOfFootInPopupView:self] : DEFAULT_FOOT_HEIGHT;
    maxOfHeight = self.delegate != nil && [self.delegate respondsToSelector:@selector(maxOfHeightInPopupView:)] ? [self.delegate maxOfHeightInPopupView:self] : DEFAULT_MAX_HEIGHT;
    
    titleOffset = self.delegate != nil && [self.delegate respondsToSelector:@selector(titleOffsetInPopupView:)] ? [self.delegate titleOffsetInPopupView:self] : DEFAULT_TITLE_OFFSET;
    
    widthOfContent = self.delegate != nil && [self.delegate respondsToSelector:@selector(widthOfContentInPopupView:)] ? [self.delegate widthOfContentInPopupView:self] : DEFAULT_WIDTH_OF_CONTENT;
    
    if(self.delegate != nil && [self.delegate respondsToSelector:@selector(widthOfBorderInPopupView:)] && [self.delegate respondsToSelector:@selector(ColorOfBorderInPopupView:)]){
        widthOfBorder = [self.delegate widthOfBorderInPopupView:self];
        self.layer.borderWidth = widthOfBorder;
        self.layer.borderColor = [[self.delegate ColorOfBorderInPopupView:self] CGColor];
        
        self.bounds = CGRectMake(-widthOfBorder, -widthOfBorder, self.bounds.size.width + 2 * widthOfBorder, self.bounds.size.height + 2 * widthOfBorder);
    }
    
    numberOfItemPerRow = (int)((widthOfContent - marginLeft - marginRight - widthOfItem) / (widthOfItem + columnDistance)) + 1;
    //NSLog(@"%d",[self.dataDelegate numberOfItemInView]);
    totalRows = [self.dataDelegate numberOfItemInPopupView:self] % numberOfItemPerRow == 0 ? [self.dataDelegate numberOfItemInPopupView:self] / numberOfItemPerRow : [self.dataDelegate numberOfItemInPopupView:self] / numberOfItemPerRow + 1;
    
    float totalContentHeight =  marginTop + marginBottom + heightOfItem + (totalRows - 1) * (heightOfItem + rowDistance);
    float maxContentHeight = maxOfHeight - heightOfHead - heightOfFoot;
    
    float totalHeight = MIN(totalContentHeight,maxContentHeight) + heightOfHead + heightOfFoot;
    
    self.frame = CGRectMake(0, 0, widthOfContent + 2 * widthOfBorder, totalHeight + 2 * widthOfBorder);
    contentView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, heightOfHead, widthOfContent, MIN(totalContentHeight,maxContentHeight))];
    contentView.contentSize = CGSizeMake(0, totalContentHeight);
    contentView.backgroundColor = [UIColor whiteColor];
    
    for(int i = 0; i < [self.dataDelegate numberOfItemInPopupView:self]; i ++){
        int row = i / numberOfItemPerRow;
        int column = i % numberOfItemPerRow;
        
        float x = marginLeft + column * (widthOfItem + columnDistance);
        float y = marginTop + row * (heightOfItem + rowDistance);
        
        UIView *container = [[UIView alloc] initWithFrame:CGRectMake(x, y, widthOfItem, heightOfItem)];
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(0, 0, widthOfItem, heightOfItem);
        button.tag = i;
        [button addTarget:self action:@selector(touchItem:) forControlEvents:UIControlEventTouchUpInside];
        [container addSubview:button];
        
        
        UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(titleOffset.x, titleOffset.y, widthOfItem, heightOfItem)];
        title.text = [self.dataDelegate popupView:self titleAtIndex:i];
        [container addSubview:title];
        container.tag = i;
        
        [contentView addSubview:container];
        
        [items addObject:container];
    }
    
    
    if(heightOfHead > 0){
        if(self.delegate != nil && [self.delegate respondsToSelector:@selector(viewOfHeadInPopupView:)]){
            headView = [self.delegate viewOfHeadInPopupView:self];
            headView.frame = CGRectMake(0, 0, widthOfContent, heightOfHead);
        }
        else{
            headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, widthOfContent, heightOfHead)];
            headView.backgroundColor = [UIColor blueColor];
        }
    }
    if(heightOfFoot > 0){
        if(self.delegate != nil && [self.delegate respondsToSelector:@selector(viewOfFootInPopupView:)]){
            footView = [self.delegate viewOfFootInPopupView:self];
            footView.frame = CGRectMake(0, contentView.frame.origin.y + contentView.frame.size.height, widthOfContent, heightOfFoot);
        }
        else{
            footView = [[UIView alloc] initWithFrame:CGRectMake(0, contentView.frame.origin.y + contentView.frame.size.height, widthOfContent, heightOfFoot)];
            footView.backgroundColor = [UIColor yellowColor];
        }
    }
    
    if(headView != nil){
        [self addSubview:headView];
    }
    if(footView != nil){
        [self addSubview:footView];
    }
    
    [self addSubview:contentView];
}

#pragma mark - Private Methods

- (void)touchItem:(id)sender
{
    UIButton *button = (UIButton *)sender;
    if(self.delegate != nil && [self.delegate respondsToSelector:@selector(popupView:didSelectAtIndex:)]){
        int index = (int)button.tag;
        [self.delegate popupView:self didSelectAtIndex:index];
    }
}

#pragma mark - Public Method
- (void)showCenterInView:(UIView *)view
{
    self.center = view.center;
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

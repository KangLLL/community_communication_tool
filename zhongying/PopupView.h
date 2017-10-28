//
//  PopupView.h
//  zhongying
//
//  Created by LI K on 8/4/14.
//  Copyright (c) 2014 lik. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PopupViewDataDelegate.h"
#import "PopupViewDelegate.h"

@interface PopupView : UIView{
    NSMutableArray *items;
    
    int numberOfItemPerRow;
    int totalRows;
    
    float heightOfItem;
    float widthOfItem;
    float rowDistance;
    float columnDistance;
    
    float marginTop;
    float marginBottom;
    float marginLeft;
    float marginRight;
    
    float heightOfHead;
    float heightOfFoot;
    
    float maxOfHeight;
    float widthOfContent;
    float widthOfBorder;
    CGPoint titleOffset;
    
    NSTimeInterval animationTime;
    
    
    UIView *headView;
    UIView *footView;
    UIScrollView *contentView;
}

@property (strong) IBOutlet id<PopupViewDataDelegate> dataDelegate;
@property (weak) IBOutlet id<PopupViewDelegate> delegate;

- (void)reloadData;
- (void)showCenterInView:(UIView *)view;
- (void)touchItem:(id)sender;
@end

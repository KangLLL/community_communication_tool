//
//  FoldableView.h
//  zhongying
//
//  Created by lik on 14-3-29.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FoldableViewDelegate.h"
#import "FoldableViewDataDelegate.h"

@interface FoldableView : UIView{
    NSMutableArray *items;
    BOOL isFold;
    
    int numberOfItemPerRow;
    int totalRows;
    
    int foldRow;
    float heightOfItem;
    float widthOfItem;
    float rowDistance;
    float columnDistance;
    
    float marginTop;
    float marginBottom;
    float marginLeft;
    float marginRight;
    
    NSTimeInterval animationTime;
}

@property (strong) IBOutlet id<FoldableViewDataDelegate> dataDelegate;
@property (weak) IBOutlet id<FoldableViewDelegate> delegate;

@property (strong) IBOutlet NSLayoutConstraint *heightConstraint;

- (void)foldView;
- (void)unfoldView;
- (void)reloadData;
- (BOOL)isFolded;

- (void)touchItem:(id)sender;

@end

//
//  EditFoldableView.h
//  zhongying
//
//  Created by lik on 14-4-9.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import "SelectFoldableView.h"
#import "CommonEnum.h"
#import "EditFoldableViewDelegate.h"

@interface EditFoldableView : SelectFoldableView{
    NSMutableDictionary *tipsButton;
}

@property (strong) UIImage *imageSelect;
@property (strong) UIImage *imageUnselect;
@property (assign) CGRect imageFrame;
@property (assign) FoldableEditType editType;

@property (strong) NSMutableArray *selections;
@property (weak) IBOutlet id<EditFoldableViewDelegate> delegate;

- (void)changeState;

@end

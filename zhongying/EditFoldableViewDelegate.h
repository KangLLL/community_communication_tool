//
//  EditFoldableViewDelegate.h
//  zhongying
//
//  Created by lik on 14-4-9.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FoldableViewDelegate.h"
#import "CommonEnum.h"

@class EditFoldableView;

@protocol EditFoldableViewDelegate <FoldableViewDelegate>

@optional
- (void)editFoldableView:(EditFoldableView *)editView changeToState:(FoldableEditType)newType;

@end

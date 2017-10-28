//
//  FoldableViewDelegate.h
//  zhongying
//
//  Created by lik on 14-3-29.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import <Foundation/Foundation.h>
@class FoldableView;

@protocol FoldableViewDelegate <NSObject>

@optional
- (int)numberOfRowInFold;

- (float)heightOfItemInView;
- (float)widthOfItemInView;

- (float)rowDistance;
- (float)columnDistance;

- (float)marginOfTopInView;
- (float)marginOfBottomInView;
- (float)marginOfLeftInView;
- (float)marginOfRightInView;

- (NSTimeInterval)foldAnimationTime;
- (void)animationFinished:(BOOL)finished;

- (void)foldableView:(FoldableView *)foldableView didSelectAtIndex:(int)index;

@end

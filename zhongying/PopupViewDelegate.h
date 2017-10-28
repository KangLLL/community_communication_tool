//
//  PopupViewDelegate.h
//  zhongying
//
//  Created by LI K on 8/4/14.
//  Copyright (c) 2014 lik. All rights reserved.
//

#import <Foundation/Foundation.h>
@class PopupView;


@protocol PopupViewDelegate <NSObject>

@optional
- (float)heightOfItemInPopupView:(PopupView *)view;
- (float)widthOfItemInPopupView:(PopupView *)view;

- (float)rowDistanceInPopupView:(PopupView *)view;
- (float)columnDistanceInPopupView:(PopupView *)view;

- (float)marginOfTopInPopupView:(PopupView *)view;
- (float)marginOfBottomInPopupView:(PopupView *)view;
- (float)marginOfLeftInPopupView:(PopupView *)view;
- (float)marginOfRightInPopupView:(PopupView *)view;

- (float)heightOfHeadInPopupView:(PopupView *)view;
- (float)heightOfFootInPopupView:(PopupView *)view;
- (float)maxOfHeightInPopupView:(PopupView *)view;
- (float)widthOfContentInPopupView:(PopupView *)view;

- (CGPoint)titleOffsetInPopupView:(PopupView *)view;
- (UIView *)viewOfHeadInPopupView:(PopupView *)view;
- (UIView *)viewOfFootInPopupView:(PopupView *)view;


- (UIColor *)ColorOfBorderInPopupView:(PopupView *)view;
- (float)widthOfBorderInPopupView:(PopupView *)view;
- (void)popupView:(PopupView *)popupView didSelectAtIndex:(int)index;

@end

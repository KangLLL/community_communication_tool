//
//  PopupViewDataDelegate.h
//  zhongying
//
//  Created by LI K on 8/4/14.
//  Copyright (c) 2014 lik. All rights reserved.
//

#import <Foundation/Foundation.h>
@class PopupView;

@protocol PopupViewDataDelegate <NSObject>

- (int)numberOfItemInPopupView:(PopupView *)popupView;
- (NSString *)popupView:(PopupView *)popupView titleAtIndex:(int)index;


@end

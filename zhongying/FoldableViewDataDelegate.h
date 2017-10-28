//
//  FoldableViewDataDelegate.h
//  zhongying
//
//  Created by lik on 14-3-29.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import <Foundation/Foundation.h>
@class FoldableView;

@protocol FoldableViewDataDelegate <NSObject>

- (int)numberOfItemInView;
- (NSString *)foldableView:(FoldableView *)foldableView titleAtIndex:(int)index;

@end

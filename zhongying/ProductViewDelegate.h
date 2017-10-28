//
//  ProductViewDelegate.h
//  zhongying
//
//  Created by lk on 14-4-24.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ProductsView;

@protocol ProductViewDelegate <NSObject>

@optional

- (void)productsView:(ProductsView *)view touchProductAtIndex:(int)index;

@end

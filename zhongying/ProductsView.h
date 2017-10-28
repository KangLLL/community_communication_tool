//
//  ProductsView.h
//  zhongying
//
//  Created by lk on 14-4-24.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProductViewDelegate.h"

@interface ProductsView : UIView

@property (weak) IBOutlet id<ProductViewDelegate> delegate;

- (float)setView:(NSArray *)products;
+ (float)getHeight:(NSArray *)products withWidth:(float)width;


@end

//
//  ProductCellView.h
//  zhongying
//
//  Created by lk on 14-4-24.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProductParameter.h"

@interface ProductCellView : UIView

- (float)setCell:(ProductParameter *)param withButtonTarget:(id)target andSelector:(SEL)selector;
+ (float)getHeight:(ProductParameter *)param withWidth:(float)width;

@end

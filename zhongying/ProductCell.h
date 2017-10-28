//
//  ProductCell.h
//  zhongying
//
//  Created by lk on 14-4-24.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProductParameter.h"

@interface ProductCell : UITableViewCell{
    UILabel *labelName;
    UILabel *labelAttribute;
    UIImageView *imageArrow;
    UILabel *labelOrderType;
    UILabel *labelQuantity;
}

- (void)setCell:(ProductParameter *)param withOrderType:(NSString *)orderType;
+ (float)getHeight:(ProductParameter *)param withWidth:(float)width;

@end

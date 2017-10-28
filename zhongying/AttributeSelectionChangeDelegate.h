//
//  AttributeSelectionChangeDelegate.h
//  zhongying
//
//  Created by lk on 14-5-5.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import <Foundation/Foundation.h>
@class GroupAttributeCell;

@protocol AttributeSelectionChangeDelegate <NSObject>

@required
- (void)attributeCellSelectionChange:(GroupAttributeCell *)cell;

@end

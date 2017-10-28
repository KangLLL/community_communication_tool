//
//  GroupAttributeCell.h
//  zhongying
//
//  Created by lk on 14-4-22.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AttributeSelectionChangeDelegate.h"

@interface GroupAttributeCell : UITableViewCell{
    NSArray *selections;
    NSArray *optionButtons;
    NSArray *optionLabels;
    NSArray *productAttributes;
}

@property (weak) IBOutlet id<AttributeSelectionChangeDelegate> delegate;

- (void)setAttributes:(NSArray *)attributes;
- (NSArray *)getSelections;

//- (NSString *)getSelections;
//- (NSString *)getSelectionsAttributeDescription;
//- (NSString *)getInvalidSelectionString;

+ (float)getCellHeightOfAttributes:(NSArray *)attributes withContentWidth:(float)width;

@end

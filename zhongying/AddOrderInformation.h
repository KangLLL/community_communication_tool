//
//  AddOrderInformation.h
//  zhongying
//
//  Created by lk on 14-4-23.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AddOrderInformation : NSObject

@property (strong) NSString *productId;
@property (strong) NSString *groupId;
@property (assign) BOOL isGroup;
@property (strong) NSString *productName;
@property (strong) NSString *productPrice;
@property (strong) NSString *allProductAttributes;
@property (strong) NSString *allAttributeDescription;
@property (strong) NSString *singleSelectAttributes;
@property (assign) float totalAttributePrice;
@property (assign) int limitRestrict;
@property (assign) int count;
@property (strong) NSString *buyId;
@property (strong) NSString *detailUrl;

- (void)setAttributesBySelection:(NSArray *)selection withProduct:(NSArray *)attributes;

@end

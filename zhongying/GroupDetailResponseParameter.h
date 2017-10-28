//
//  GroupDetailParameter.h
//  zhongying
//
//  Created by lk on 14-4-20.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ResponseParameter.h"

@interface GroupDetailResponseParameter : NSObject<ResponseParameter>

@property (strong) NSString *groupId;
@property (strong) NSString *productId;
@property (strong) NSString *productName;
@property (strong) NSString *originalPrice;
@property (strong) NSString *groupPrice;
@property (strong) NSString *discount;
@property (assign) int maxRestrict;
@property (assign) int limitRestrict;
@property (strong) NSString *imageUrl;
@property (strong) NSString *detailUrl;
@property (strong) NSString *finishTime;
@property (strong) NSArray *parameters;
@property (strong) NSArray *suggestions;
@property (assign) int singleAttributeCount;
@property (assign) int multiplyAttributeCount;
@property (strong) NSArray *attributes;
           
@end

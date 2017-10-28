//
//  GetShopDetailResponseParameter.h
//  zhongying
//
//  Created by lk on 14-4-21.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ResponseParameter.h"

@interface ShopDetailResponseParameter : NSObject<ResponseParameter>

@property (strong) NSString *shopName;
@property (strong) NSString *address;
@property (strong) NSString *phone;
@property (strong) NSString *mapX;
@property (strong) NSString *mapY;
@property (strong) NSString *area;
@property (strong) NSString *businessHour;
@property (strong) NSString *detailUrl;
@property (strong) NSString *primaryCategory;
@property (strong) NSString *subCategory;

@end

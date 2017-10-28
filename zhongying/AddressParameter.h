//
//  AddressParameter.h
//  zhongying
//
//  Created by lk on 14-4-14.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ResponseParameter.h"

@interface AddressParameter : NSObject<ResponseParameter>

@property (strong) NSString *addressId;
@property (strong) NSString *name;
@property (strong) NSString *address;
@property (strong) NSString *phone;
@property (strong) NSString *zipCode;
@property (assign) int provinceId;
@property (assign) int cityId;
@property (assign) int districtId;
@property (strong) NSString *provinceName;
@property (strong) NSString *cityName;
@property (strong) NSString *districtName;


@end

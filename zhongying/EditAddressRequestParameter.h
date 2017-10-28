//
//  EditAddressRequestParameter.h
//  zhongying
//
//  Created by lk on 14-4-14.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import "CommonRequestParameter.h"
#import "RequestParameter.h"

@interface EditAddressRequestParameter : CommonRequestParameter<RequestParameter>

@property (strong) NSString *addressId;
@property (strong) NSString *name;
@property (strong) NSString *phone;
@property (strong) NSString *address;
@property (assign) int provinceId;
@property (assign) int cityId;
@property (assign) int districtId;
@property (strong) NSString *zipCode;


@end

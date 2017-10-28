//
//  AddOrderRequestParameter.h
//  zhongying
//
//  Created by lk on 14-4-23.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import "CommonRequestParameter.h"
#import "RequestParameter.h"

@interface AddOrderRequestParameter : CommonRequestParameter<RequestParameter>

@property (strong) NSString *productId;
@property (strong) NSString *addressId;
@property (assign) int count;
@property (strong) NSString *attribute;
@property (strong) NSString *productAttribute;
@property (strong) NSString *expressId;
@property (strong) NSString *expressName;
@property (strong) NSString *payId;
@property (strong) NSString *payName;
@property (assign) NSString *productPrice;
@property (assign) NSString *orderPrice;
@property (assign) NSString *shipPrice;
@property (assign) NSString *insurePrice;


@end

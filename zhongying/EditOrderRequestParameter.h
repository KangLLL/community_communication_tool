//
//  EditOrderRequestParameter.h
//  zhongying
//
//  Created by lk on 14-4-23.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import "CommonRequestParameter.h"
#import "RequestParameter.h"

@interface EditOrderRequestParameter : CommonRequestParameter<RequestParameter>

@property (strong) NSString *orderId;
@property (strong) NSString *shipPrice;
@property (strong) NSString *payId;
@property (strong) NSString *payName;
@property (strong) NSString *expressId;
@property (strong) NSString *expressName;
@property (strong) NSString *addressId;
@property (strong) NSString *insurePrice;
@property (strong) NSString *orderPrice;


@end

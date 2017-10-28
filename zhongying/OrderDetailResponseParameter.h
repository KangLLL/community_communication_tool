//
//  OrderDetailResponseParameter.h
//  zhongying
//
//  Created by lk on 14-4-23.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ResponseParameter.h"

@interface OrderDetailResponseParameter : NSObject<ResponseParameter>

@property (strong) NSString *orderId;
@property (strong) NSString *orderSn;
@property (strong) NSString *time;
@property (strong) NSString *status;
@property (strong) NSString *receiverName;
@property (strong) NSString *phone;
@property (strong) NSString *address;
@property (strong) NSString *addressId;
@property (strong) NSString *expressName;
@property (strong) NSString *shipId;
@property (assign) NSString *shipPrice;
@property (assign) NSString *insurePrice;
@property (strong) NSString *detailUrl;
@property (assign) NSString *productPrice;
@property (assign) NSString *orderPrice;
@property (strong) NSString *payId;
@property (strong) NSString *payName;
@property (assign) float remainingMoney;
@property (strong) NSArray *addresses;
@property (strong) NSArray *pays;
@property (strong) NSArray *ships;
@property (strong) NSArray *products;
@property (strong) NSString *orderType;

@end

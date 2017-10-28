//
//  EditOrderRequestParameter.m
//  zhongying
//
//  Created by lk on 14-4-23.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import "EditOrderRequestParameter.h"

@implementation EditOrderRequestParameter

@synthesize orderId, shipPrice,payId, payName, expressId, expressName, addressId, insurePrice, orderPrice;

- (NSDictionary *)convertToRequest
{
    NSMutableDictionary *result = [NSMutableDictionary dictionaryWithDictionary:[super getCommonDictionary]];
    
    NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys:self.orderId,@"order_id",self.shipPrice,@"shipping_fee",self.payId,@"pay_id",self.payName,@"pay_name",self.expressId,@"s_id",self.expressName,@"s_name",self.addressId,@"add_id",self.insurePrice,@"insure_fee",self.orderPrice,@"order_price", nil];
    
    [result addEntriesFromDictionary:parameters];
    return result;
}

@end

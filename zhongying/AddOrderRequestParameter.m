//
//  AddOrderRequestParameter.m
//  zhongying
//
//  Created by lk on 14-4-23.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import "AddOrderRequestParameter.h"

@implementation AddOrderRequestParameter

@synthesize productId, addressId, count, attribute, productAttribute, expressId, expressName, payId, payName, productPrice, orderPrice, shipPrice, insurePrice;

- (NSDictionary *)convertToRequest
{
    NSMutableDictionary *result = [NSMutableDictionary dictionaryWithDictionary:[super getCommonDictionary]];
    
    NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys:self.productId,@"goods_id",self.addressId,@"add_id",[NSString stringWithFormat:@"%d", self.count],@"num",self.attribute,@"attr",self.productAttribute,@"goods_attr",self.expressId,@"s_id",self.expressName,@"s_name",self.payId,@"pay_id",self.payName,@"pay_name",self.productPrice,@"goods_price",self.orderPrice,@"order_price",self.shipPrice,@"shipping_fee",self.insurePrice,@"insure_fee",nil];
    
    [result addEntriesFromDictionary:parameters];
    return result;
}
@end

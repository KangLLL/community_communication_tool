//
//  OrderDetailResponseParameter.m
//  zhongying
//
//  Created by lk on 14-4-23.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import "OrderDetailResponseParameter.h"
#import "AddressParameter.h"
#import "PayParameter.h"
#import "ShipParameter.h"
#import "ProductParameter.h"

@implementation OrderDetailResponseParameter

@synthesize orderId, orderSn, time, status, receiverName, phone, address, expressName, shipPrice, insurePrice, detailUrl, productPrice, orderPrice, payId, payName, remainingMoney, addresses, pays, ships, products,orderType, addressId, shipId;

- (void)initialFromDictionaryResponse:(NSDictionary *)response
{
    self.orderId = [response objectForKey:@"order_id"];
    self.orderSn = [response objectForKey:@"order_sn"];
    self.time = [response objectForKey:@"addtime"];
    self.status = [response objectForKey:@"status"];
    self.receiverName = [response objectForKey:@"consignee"];
    self.addressId = [response objectForKey:@"add_id"];
    self.address = [response objectForKey:@"address"];
    self.phone = [response objectForKey:@"tel"];
    self.expressName = [response objectForKey:@"ship_name"];
    self.shipId = [response objectForKey:@"ship_id"];
    self.shipPrice = [response objectForKey:@"shipping_fee"];
    if([[response objectForKey:@"insure_fee"] intValue] == 0){
        self.insurePrice = [response objectForKey:@"insure_fee"];
    }
    else{
        self.insurePrice = [NSString stringWithFormat:@"%d%%",[[response objectForKey:@"insure_fee"] intValue]];
    }
    self.detailUrl = [response objectForKey:@"info"];
    self.productPrice = [response objectForKey:@"goods_amount"];
    self.orderPrice = [response objectForKey:@"order_amount"];
    self.payId = [response objectForKey:@"pay_id"];
    self.payName = [response objectForKey:@"pay_name"];
    self.remainingMoney = [[response objectForKey:@"mymoney"] floatValue];
    self.orderType = [response objectForKey:@"order_type"];
    
    NSMutableArray *temp = [NSMutableArray array];
    NSArray *array = [response objectForKey:@"addList"];
    for (NSDictionary *dict in array) {
        AddressParameter *param = [[AddressParameter alloc] init];
        [param initialFromDictionaryResponse:dict];
        [temp addObject:param];
    }
    self.addresses = temp;
    
    temp = [NSMutableArray array];
    array = [response objectForKey:@"pay_type"];
    for (NSDictionary *dict in array) {
        PayParameter *param = [[PayParameter alloc] init];
        [param initialFromDictionaryResponse:dict];
        [temp addObject:param];
    }
    self.pays = temp;
    
    temp = [NSMutableArray array];
    array = [response objectForKey:@"ship"];
    for (NSDictionary *dict in array) {
        ShipParameter *param = [[ShipParameter alloc] init];
        [param initialFromDictionaryResponse:dict];
        [temp addObject:param];
    }
    self.ships = temp;
    
    temp = [NSMutableArray array];
    array = [response objectForKey:@"goods"];
    for (NSDictionary *dict in array) {
        ProductParameter *param = [[ProductParameter alloc] init];
        [param initialFromDictionaryResponse:dict];
        [temp addObject:param];
    }
    self.products = temp;
}

@end

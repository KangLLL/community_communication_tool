//
//  AddOrderResponseParameter.m
//  zhongying
//
//  Created by lk on 14-4-23.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import "AddOrderResponseParameter.h"

@implementation AddOrderResponseParameter

@synthesize orderId, orderSn;

- (void)initialFromDictionaryResponse:(NSDictionary *)response
{
    self.orderId = [[response objectForKey:@"order_id"] stringValue];
    self.orderSn = [response objectForKey:@"order_sn"];
}

@end

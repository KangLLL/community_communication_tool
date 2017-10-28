//
//  OrderParameter.m
//  zhongying
//
//  Created by lk on 14-4-23.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import "OrderParameter.h"

@implementation OrderParameter

@synthesize orderId, orderSn, time;

- (void)initialFromDictionaryResponse:(NSDictionary *)response
{
    self.orderId = [response objectForKey:@"order_id"];
    self.orderSn = [response objectForKey:@"order_sn"];
    self.time = [response objectForKey:@"addtime"];
    self.status = [response objectForKey:@"status"];
}

@end

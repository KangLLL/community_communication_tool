//
//  OrderDetailRequestParameter.m
//  zhongying
//
//  Created by lk on 14-4-23.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import "OrderDetailRequestParameter.h"

@implementation OrderDetailRequestParameter

@synthesize orderId;

- (NSDictionary *)convertToRequest
{
    NSMutableDictionary *result = [NSMutableDictionary dictionaryWithDictionary:[super getCommonDictionary]];
    
    [result setObject:self.orderId forKey:@"order_id"];
    return result;
}


@end

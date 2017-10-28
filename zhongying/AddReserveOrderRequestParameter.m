//
//  AddReserveOrderRequestParameter.m
//  zhongying
//
//  Created by lk on 14-4-24.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import "AddReserveOrderRequestParameter.h"

@implementation AddReserveOrderRequestParameter

@synthesize reserveId;

- (NSDictionary *)convertToRequest
{
    NSMutableDictionary *result = [NSMutableDictionary dictionaryWithDictionary:[super convertToRequest]];
    
    [result setObject:self.reserveId forKey:@"e_id"];
    [result setObject:@"booking" forKey:@"e_code"];
    return result;
}


@end

//
//  PayParameter.m
//  zhongying
//
//  Created by lk on 14-4-23.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import "PayParameter.h"

@implementation PayParameter

@synthesize payId, payName, feePrice;

- (void)initialFromDictionaryResponse:(NSDictionary *)response
{
    self.payId = [response objectForKey:@"pay_id"];
    self.payName = [response objectForKey:@"pay_name"];
    self.feePrice = [response objectForKey:@"price"];
}

@end

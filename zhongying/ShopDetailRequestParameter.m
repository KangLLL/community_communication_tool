//
//  GetShopDetailRequestParameter.m
//  zhongying
//
//  Created by lk on 14-4-21.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import "ShopDetailRequestParameter.h"

@implementation ShopDetailRequestParameter

@synthesize shopId;

- (NSDictionary *)convertToRequest
{
    NSMutableDictionary *result = [NSMutableDictionary dictionaryWithDictionary:[super getCommonDictionary]];
    
    [result setObject:self.shopId forKey:@"id"];
    return result;
}


@end

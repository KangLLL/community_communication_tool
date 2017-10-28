//
//  GetMyUtilitiesRequestParameter.m
//  zhongying
//
//  Created by lik on 14-3-25.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import "GetMyUtilitiesRequestParameter.h"

@implementation GetMyUtilitiesRequestParameter

- (NSDictionary *)convertToRequest
{
    NSMutableDictionary *result = [NSMutableDictionary dictionaryWithDictionary:[super getCommonDictionary]];
    [result setObject:@"1" forKey:@"tid"];
    return result;
}

@end

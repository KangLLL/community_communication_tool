//
//  GetMyParkingRequestParameter.m
//  zhongying
//
//  Created by lik on 14-3-25.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import "GetMyParkingRequestParameter.h"

@implementation GetMyParkingRequestParameter

- (NSDictionary *)convertToRequest
{
    NSMutableDictionary *result = [NSMutableDictionary dictionaryWithDictionary:[super getCommonDictionary]];
    [result setObject:@"2" forKey:@"tid"];
    return result;
}

@end

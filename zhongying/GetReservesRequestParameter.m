//
//  GetReservesRequestParameter.m
//  zhongying
//
//  Created by lk on 14-4-24.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import "GetReservesRequestParameter.h"

@implementation GetReservesRequestParameter

- (NSDictionary *)convertToRequest
{
    NSMutableDictionary *result = [NSMutableDictionary dictionaryWithDictionary:[super getCommonDictionary]];
    
    [result setObject:[NSString stringWithFormat:@"%d",1] forKey:@"type_id"];
    return result;
}

@end

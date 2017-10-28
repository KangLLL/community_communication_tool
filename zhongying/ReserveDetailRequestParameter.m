//
//  ReserveDetailRequestParameter.m
//  zhongying
//
//  Created by lk on 14-4-24.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import "ReserveDetailRequestParameter.h"

@implementation ReserveDetailRequestParameter

@synthesize reserveId;

- (NSDictionary *)convertToRequest
{
    NSMutableDictionary *result = [NSMutableDictionary dictionaryWithDictionary:[super getCommonDictionary]];
    
    [result setObject:self.reserveId forKey:@"gid"];
    return result;
}

@end

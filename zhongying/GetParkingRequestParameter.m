//
//  GetParkingRequestParameter.m
//  zhongying
//
//  Created by lik on 14-3-22.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import "GetParkingRequestParameter.h"

@implementation GetParkingRequestParameter

@synthesize communityId;

- (NSDictionary *)convertToRequest
{
    NSMutableDictionary *result = [NSMutableDictionary dictionaryWithDictionary:[super getCommonDictionary]];
    [result setObject:@"2" forKey:@"tid"];
    [result setObject:self.communityId forKey:@"cid"];
    
    return result;
}

@end

//
//  GetUtilitiesRequestParameter.m
//  zhongying
//
//  Created by lik on 14-3-22.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import "GetUtilitiesRequestParameter.h"

@implementation GetUtilitiesRequestParameter

@synthesize communityId;

- (NSDictionary *)convertToRequest
{
    NSMutableDictionary *result = [NSMutableDictionary dictionaryWithDictionary:[super getCommonDictionary]];
    [result setObject:@"1" forKey:@"tid"];
    [result setObject:self.communityId forKey:@"cid"];
    
    return result;
}


@end

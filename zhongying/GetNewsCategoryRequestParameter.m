//
//  GetNewsRequestParameter.m
//  zhongying
//
//  Created by lk on 14-4-22.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import "GetNewsCategoryRequestParameter.h"

@implementation GetNewsCategoryRequestParameter

@synthesize communityId;

- (NSDictionary *)convertToRequest
{
    NSMutableDictionary *result = [NSMutableDictionary dictionaryWithDictionary:[super getCommonDictionary]];
    
    [result setObject:self.communityId forKey:@"commid"];
    return result;
}

@end

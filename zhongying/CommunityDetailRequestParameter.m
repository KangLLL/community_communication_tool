//
//  CommunityDetailRequestParameter.m
//  zhongying
//
//  Created by lk on 14-5-24.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import "CommunityDetailRequestParameter.h"

@implementation CommunityDetailRequestParameter

@synthesize communityId;

- (NSDictionary *)convertToRequest
{
    NSMutableDictionary *result = [NSMutableDictionary dictionaryWithDictionary:[super getCommonDictionary]];
    
    [result setObject:self.communityId forKey:@"commid"];
    
    return result;
}

@end

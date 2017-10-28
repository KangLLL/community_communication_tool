//
//  GetComplaintRequestParameter.m
//  zhongying
//
//  Created by lik on 14-3-23.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import "GetComplaintRequestParameter.h"

@implementation GetComplaintRequestParameter

@synthesize communityId;

- (NSDictionary *)convertToRequest
{
    NSMutableDictionary *result = [NSMutableDictionary dictionaryWithDictionary:[super getCommonDictionary]];
    [result setObject:@"0" forKey:@"tid"];
    [result setObject:self.communityId forKey:@"cid"];
    
    return result;
}

@end

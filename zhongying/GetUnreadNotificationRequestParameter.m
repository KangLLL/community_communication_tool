//
//  GetUnreadMessageRequestParameter.m
//  zhongying
//
//  Created by lk on 14-4-15.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import "GetUnreadNotificationRequestParameter.h"

@implementation GetUnreadNotificationRequestParameter

- (NSDictionary *)convertToRequest
{
    NSMutableDictionary *result = [NSMutableDictionary dictionaryWithDictionary:[super getCommonDictionary]];
    [result setObject:self.communityId forKey:@"cid"];
    return result;
}

@end

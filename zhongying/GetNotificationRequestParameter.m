//
//  GetNotificationRequestParameter.m
//  zhongying
//
//  Created by lik on 14-3-24.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import "GetNotificationRequestParameter.h"

@implementation GetNotificationRequestParameter

@synthesize communityId;

- (NSDictionary *)convertToRequest
{
    NSMutableDictionary *result = [NSMutableDictionary dictionaryWithDictionary:[super getCommonDictionary]];
    
    [result setValue:self.communityId forKey:@"cid"];
    return result;
}



@end

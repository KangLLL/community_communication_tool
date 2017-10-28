//
//  GetHouseDetailRequestParameter.m
//  zhongying
//
//  Created by lik on 14-3-24.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import "GetHouseDetailRequestParameter.h"

@implementation GetHouseDetailRequestParameter

@synthesize password;

- (NSDictionary *)convertToRequest
{
    NSMutableDictionary *result = [NSMutableDictionary dictionaryWithDictionary:[super getCommonDictionary]];
    
    [result setObject:self.messageId forKey:@"id"];
    return result;
}

@end

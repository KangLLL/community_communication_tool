//
//  DeleteRentRequestParameter.m
//  zhongying
//
//  Created by lik on 14-3-24.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import "DeleteRentRequestParameter.h"

@implementation DeleteRentRequestParameter

@synthesize messageId;

- (NSDictionary *)convertToRequest
{
    NSMutableDictionary *result = [NSMutableDictionary dictionaryWithDictionary:[super getCommonDictionary]];
    
    [result setObject:self.messageId forKey:@"id"];
    return result;
}

@end

//
//  DeleteComplaintRequestParameter.m
//  zhongying
//
//  Created by lk on 14-4-26.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import "DeleteComplaintRequestParameter.h"

@implementation DeleteComplaintRequestParameter

@synthesize messageId;

- (NSDictionary *)convertToRequest
{
    NSMutableDictionary *result = [NSMutableDictionary dictionaryWithDictionary:[super getCommonDictionary]];
    
    [result setObject:self.messageId forKey:@"id"];
    return result;
}

@end

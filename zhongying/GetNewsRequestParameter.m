//
//  NewsDetailRequestParameter.m
//  zhongying
//
//  Created by lk on 14-4-22.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import "GetNewsRequestParameter.h"

@implementation GetNewsRequestParameter

@synthesize categoryId;

- (NSDictionary *)convertToRequest
{
    NSMutableDictionary *result = [NSMutableDictionary dictionaryWithDictionary:[super getCommonDictionary]];
    
    [result setObject:self.categoryId forKey:@"catid"];
    return result;
}


@end

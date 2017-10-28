//
//  GetGroupsRequestParameter.m
//  zhongying
//
//  Created by apple on 14-4-13.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import "GetGroupsRequestParameter.h"

@implementation GetGroupsRequestParameter

- (NSDictionary *)convertToRequest
{
    NSMutableDictionary *result = [NSMutableDictionary dictionaryWithDictionary:[super getCommonDictionary]];
    
    [result setObject:[NSString stringWithFormat:@"%d",0] forKey:@"type_id"];
    return result;
}

@end

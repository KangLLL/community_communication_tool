//
//  GetNeighbourMessageRequestParameter.m
//  zhongying
//
//  Created by lik on 14-4-10.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import "GetNeighbourMessagesRequestParameter.h"

@implementation GetNeighbourMessagesRequestParameter

@synthesize peopleId;

- (NSDictionary *)convertToRequest
{
    NSMutableDictionary *result = [NSMutableDictionary dictionaryWithDictionary:[super getCommonDictionary]];
    
    [result setValue:self.peopleId forKey:@"usid"];
    return result;
}


@end

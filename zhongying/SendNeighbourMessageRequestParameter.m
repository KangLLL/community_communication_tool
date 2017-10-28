//
//  SendNeighbourMessageRequestParameter.m
//  zhongying
//
//  Created by lik on 14-4-10.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import "SendNeighbourMessageRequestParameter.h"

@implementation SendNeighbourMessageRequestParameter

@synthesize toPeopleId, content;

- (NSDictionary *)convertToRequest
{
    NSMutableDictionary *result = [NSMutableDictionary dictionaryWithDictionary:[super getCommonDictionary]];
    
    [result setValue:self.toPeopleId forKey:@"usid"];
    [result setValue:self.content forKey:@"content"];
    return result;
}


@end

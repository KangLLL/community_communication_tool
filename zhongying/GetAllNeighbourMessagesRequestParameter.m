//
//  GetAllNeighbourMessagesRequestParameter.m
//  zhongying
//
//  Created by lik on 14-4-10.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import "GetAllNeighbourMessagesRequestParameter.h"

@implementation GetAllNeighbourMessagesRequestParameter

- (NSDictionary *)convertToRequest
{
    return [NSMutableDictionary dictionaryWithDictionary:[super getCommonDictionary]];
}

@end

//
//  GroupDetailResponseParameter.m
//  zhongying
//
//  Created by lk on 14-4-20.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import "GroupDetailRequestParameter.h"

@implementation GroupDetailRequestParameter

@synthesize groupId;

- (NSDictionary *)convertToRequest
{
    NSMutableDictionary *result = [NSMutableDictionary dictionaryWithDictionary:[super getCommonDictionary]];
    
    [result setObject:self.groupId forKey:@"gid"];
    return result;
}


@end

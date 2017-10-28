//
//  GetHobbyMessageRequestParameter.m
//  zhongying
//
//  Created by lik on 14-4-8.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import "GetHobbyMessageRequestParameter.h"

@implementation GetHobbyMessageRequestParameter

@synthesize peopleId;

- (NSDictionary *)convertToRequest
{
    NSMutableDictionary *result = [NSMutableDictionary dictionaryWithDictionary:[super getCommonDictionary]];
    
    [result setValue:self.peopleId forKey:@"usid"];
    
    return result;
    
}


@end

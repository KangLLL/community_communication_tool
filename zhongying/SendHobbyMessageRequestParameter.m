//
//  SendHobbyMessageRequestParameter.m
//  zhongying
//
//  Created by lik on 14-4-8.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import "SendHobbyMessageRequestParameter.h"

@implementation SendHobbyMessageRequestParameter

@synthesize toUserId, content;

- (NSDictionary *)convertToRequest
{
    NSMutableDictionary *result = [NSMutableDictionary dictionaryWithDictionary:[super getCommonDictionary]];
    
    [result setValue:self.toUserId forKey:@"usid"];
    [result setValue:self.content forKey:@"content"];
    
    return result;
}

@end

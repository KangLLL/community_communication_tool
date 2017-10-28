//
//  SameHobbyMessageParameter.m
//  zhongying
//
//  Created by lik on 14-4-8.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import "AllHobbyMessageParameter.h"

@implementation AllHobbyMessageParameter

@synthesize userId, userName, content, time;

- (void)initialFromDictionaryResponse:(NSDictionary *)response
{
    self.userId = [response objectForKey:@"usid"];
    if([response objectForKey:@"usname"] == [NSNull null]){
        self.userName = @"";
    }
    else{
        self.userName = [response objectForKey:@"usname"];
    }
    self.content = [response objectForKey:@"msg"];
    self.time = [response objectForKey:@"times"];
}

@end

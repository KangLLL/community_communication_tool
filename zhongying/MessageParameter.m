//
//  MessageParameter.m
//  zhongying
//
//  Created by lik on 14-4-8.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import "MessageParameter.h"

@implementation MessageParameter

@synthesize fromUserId, toUserId, content, time;

- (void)initialFromDictionaryResponse:(NSDictionary *)response
{
    self.fromUserId = [response objectForKey:@"send_man_id"];
    self.toUserId = [response objectForKey:@"get_man_id"];
    self.content = [response objectForKey:@"content"];
    self.time = [response objectForKey:@"time"];
}


@end

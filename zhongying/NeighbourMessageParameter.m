//
//  NeighbourMessageParameter.m
//  zhongying
//
//  Created by lik on 14-4-10.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import "NeighbourMessageParameter.h"

@implementation NeighbourMessageParameter

@synthesize fromId, toId, content, time;

- (void)initialFromDictionaryResponse:(NSDictionary *)response
{
    self.fromId = [response objectForKey:@"send_message_id"];
    self.toId = [response objectForKey:@"get_message_id"];
    self.content = [response objectForKey:@"content"];
    self.time = [response objectForKey:@"time"];
}

@end

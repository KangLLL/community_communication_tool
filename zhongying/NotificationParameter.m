//
//  NotificationParameter.m
//  zhongying
//
//  Created by lik on 14-3-24.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import "NotificationParameter.h"

@implementation NotificationParameter

@synthesize messageId, title, time, status, content;

- (void)initialFromDictionaryResponse:(NSDictionary *)response
{
    self.messageId = [response objectForKey:@"message_id"];
    self.title = [response objectForKey:@"title"];
    self.time = [response objectForKey:@"sent_time"];
    self.status = [[response objectForKey:@"readed"] intValue];
    self.content = [response objectForKey:@"message"];
}

@end

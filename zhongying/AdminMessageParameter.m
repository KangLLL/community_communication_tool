//
//  AdminMessageParameter.m
//  zhongying
//
//  Created by lk on 14-5-27.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import "AdminMessageParameter.h"

@implementation AdminMessageParameter

@synthesize messageId, title, time, messageStatus, content;

- (void)initialFromDictionaryResponse:(NSDictionary *)response
{
    self.messageId = [response objectForKey:@"message_id"];
    self.title = [response objectForKey:@"title"];
    self.content = [response objectForKey:@"message"];
    self.time = [response objectForKey:@"sent_time"];
    self.messageStatus = [[response objectForKey:@"readed"] intValue];
}

@end

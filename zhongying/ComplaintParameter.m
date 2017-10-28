//
//  ComplaintParameter.m
//  zhongying
//
//  Created by lik on 14-3-23.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import "ComplaintParameter.h"

@implementation ComplaintParameter

@synthesize messageId, userId, communityId, userName, userEmail, title, responseType, content, time, imagePath;

- (void)initialFromDictionaryResponse:(NSDictionary *)response
{
    self.messageId = [response objectForKey:@"msg_id"];
    self.userId = [response objectForKey:@"user_id"];
    self.communityId = [response objectForKey:@"comm_id"];
    self.userName = [response objectForKey:@"user_name"];
    self.userEmail = [response objectForKey:@"user_email"];
    self.title = [response objectForKey:@"msg_title"];
    self.responseType = [[response objectForKey:@"msg_status"] intValue];
    self.content = [response objectForKey:@"msg_content"];
    self.time = [response objectForKey:@"msg_time"];
    self.imagePath = [response objectForKey:@"message_img"];
}
@end

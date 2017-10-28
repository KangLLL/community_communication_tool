//
//  GetUnreadMessageResponseParameter.m
//  zhongying
//
//  Created by lk on 14-4-15.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import "GetUnreadNotificationResponseParameter.h"

@implementation GetUnreadNotificationResponseParameter

@synthesize notificationCount, neighbourMessageCount, hobbyMesssageCount;

- (void)initialFromDictionaryResponse:(NSDictionary *)response
{
    self.notificationCount = [response objectForKey:@"count"];// == [NSNull null] ? @"0" : [response objectForKey:@"count"];
    self.neighbourMessageCount = [response objectForKey:@"nh"];// == [NSNull null] ? @"0" : [response objectForKey:@"nh"];
    self.hobbyMesssageCount = [response objectForKey:@"hb"];// == [NSNull null] ? @"0" : [response objectForKey:@"hb"];
}

@end

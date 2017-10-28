//
//  GetNotificationResponseParameter.m
//  zhongying
//
//  Created by lik on 14-3-24.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import "GetNotificationResponseParameter.h"
#import "NotificationParameter.h"

@implementation GetNotificationResponseParameter

@synthesize notifications;

- (void)initialFromArrayResponse:(NSArray *)response
{
    NSMutableArray *temp = [NSMutableArray array];
    for (NSDictionary *dict in response) {
        NotificationParameter *param = [[NotificationParameter alloc] init];
        [param initialFromDictionaryResponse:dict];
        [temp addObject:param];
    }
    self.notifications = temp;
}

@end

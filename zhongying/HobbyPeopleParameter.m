//
//  HobbyPeopleParameter.m
//  zhongying
//
//  Created by lik on 14-4-8.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import "HobbyPeopleParameter.h"

@implementation HobbyPeopleParameter

@synthesize userId, userName, totalPeopleNumber, buildNo, floorNo, roomNo, communityName;

- (void)initialFromDictionaryResponse:(NSDictionary *)response
{
    self.userId = [response objectForKey:@"usid"];
    self.userName = [response objectForKey:@"name"];
    NSLog(@"%@",self.userName);
    self.totalPeopleNumber = [[response objectForKey:@"sumpeople"] intValue];
    self.buildNo = [response objectForKey:@"build"];
    self.floorNo = [response objectForKey:@"floor"];
    self.roomNo = [response objectForKey:@"num"];
    self.communityName = [response objectForKey:@"comm"];
}

@end

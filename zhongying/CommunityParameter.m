//
//  CommunityParameter.m
//  zhongying
//
//  Created by lik on 14-3-19.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import "CommunityParameter.h"

@implementation CommunityParameter

@synthesize communityName,communityId,city;

- (void)initialFromDictionaryResponse:(NSDictionary *)response
{
    self.communityName = [response objectForKey:@"name"];
    self.communityId = [response objectForKey:@"id"];
    self.city = [response objectForKey:@"city"];
}

@end

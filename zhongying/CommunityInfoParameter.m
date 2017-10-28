//
//  CommunitiInfoParameter.m
//  zhongying
//
//  Created by lik on 14-3-24.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import "CommunityInfoParameter.h"

@implementation CommunityInfoParameter

@synthesize communityId, communityName;

- (void)initialFromDictionaryResponse:(NSDictionary *)response
{
    self.communityId = [response objectForKey:@"id"];
    self.communityName = [response objectForKey:@"name"];
}

@end

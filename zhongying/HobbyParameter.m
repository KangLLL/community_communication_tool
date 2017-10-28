//
//  HobbyParameter.m
//  zhongying
//
//  Created by lik on 14-4-8.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import "HobbyParameter.h"

@implementation HobbyParameter

@synthesize hobbyId, hobbyName;

- (void)initialFromDictionaryResponse:(NSDictionary *)response
{
    self.hobbyId = [response objectForKey:@"hobby_id"];
    self.hobbyName = [response objectForKey:@"hobby_name"];
}

@end

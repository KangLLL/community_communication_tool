//
//  RegisterResponseParameter.m
//  zhongying
//
//  Created by lik on 14-3-19.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import "RegisterResponseParameter.h"
#import "CommunityParameter.h"

@implementation RegisterResponseParameter

@synthesize userId,userName,avatarPath,password,phone;

- (void)initialFromDictionaryResponse:(NSDictionary *)response
{
    NSDictionary *dict = [response objectForKey:@"userinfo"];
    self.userId = [dict objectForKey:@"uid"];
    self.userName = [dict objectForKey:@"username"];
    self.avatarPath = [dict objectForKey:@"avatar"];
    self.password = [dict objectForKey:@"password"];
    self.phone = [dict objectForKey:@"tel"];
}

@end

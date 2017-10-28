//
//  LoginResponseParameter.m
//  zhongying
//
//  Created by lik on 14-3-19.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import "LoginResponseParameter.h"

@implementation LoginResponseParameter

@synthesize userId,userName,money,point,avatarPath,communities,phone;

- (void)initialFromDictionaryResponse:(NSDictionary *)response
{
    NSDictionary *userInfo = [response objectForKey:@"userinfo"];
    self.userId = [userInfo objectForKey:@"uid"];
    self.password = [userInfo objectForKey:@"password"];
    self.userName = [userInfo objectForKey:@"username"];
    self.phone = [userInfo objectForKey:@"tel"];
    self.money = [[userInfo objectForKey:@"money"] floatValue];
    self.point = [[userInfo objectForKey:@"point"] intValue];
    self.avatarPath = [userInfo objectForKey:@"avatar"];
    NSArray *comms = [response objectForKey:@"comm"];
    if(comms != nil){
        NSMutableArray *temp = [NSMutableArray array];
        for (NSDictionary *com in comms) {
            CommunityParameter *cp = [[CommunityParameter alloc] init];
            [cp initialFromDictionaryResponse:com];
            [temp addObject:cp];
        }
        self.communities = temp;
    }
}
@end

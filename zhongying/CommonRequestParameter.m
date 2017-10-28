//
//  CommonRequestParameter.m
//  zhongying
//
//  Created by lik on 14-4-8.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import "CommonRequestParameter.h"

@implementation CommonRequestParameter

@synthesize userId, password;

- (NSDictionary *)getCommonDictionary
{
    NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys:self.userId,@"uid",self.password,@"password",nil];
    return parameters;
}

@end

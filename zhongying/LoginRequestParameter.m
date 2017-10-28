//
//  LoginRequestParameter.m
//  zhongying
//
//  Created by lik on 14-3-19.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import "LoginRequestParameter.h"

@implementation LoginRequestParameter

@synthesize name, password;

- (NSDictionary *)convertToRequest
{
    NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys:name,@"username",password,@"password",nil];
    return parameters;
}

@end

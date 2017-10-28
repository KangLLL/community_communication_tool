//
//  SendEmailRequestParameter.m
//  zhongying
//
//  Created by lik on 14-3-19.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import "SendEmailRequestParameter.h"

@implementation SendEmailRequestParameter

@synthesize userName, email;

- (NSDictionary *)convertToRequest
{
    NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys:self.userName,@"username",self.email,@"email",nil];
    return parameters;
}

@end

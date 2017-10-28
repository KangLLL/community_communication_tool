//
//  SendCodeParameter.m
//  zhongying
//
//  Created by lik on 14-3-19.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import "SendCodeRequestParameter.h"

@implementation SendCodeRequestParameter

@synthesize phoneNumber;

- (NSDictionary *)convertToRequest
{
    NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys:self.phoneNumber,@"tel",@"get_code",@"act",nil];
    return parameters;
}

@end

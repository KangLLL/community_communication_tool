//
//  VerifyPhoneRequestParameter.m
//  zhongying
//
//  Created by lk on 14-5-5.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import "VerifyPhoneRequestParameter.h"

@implementation VerifyPhoneRequestParameter

@synthesize phone;

- (NSDictionary *)convertToRequest
{
    NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys:self.phone,@"tel",nil];
    return parameters;
}

@end

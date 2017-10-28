//
//  GetUtilitiesDetailRequestParameter.m
//  zhongying
//
//  Created by lik on 14-3-24.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import "GetUtilitiesDetailRequestParameter.h"

@implementation GetUtilitiesDetailRequestParameter

@synthesize userId, password, billId;

- (NSDictionary *)convertToRequest
{
    NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys:self.userId,@"uid",self.password,@"password",self.billId,@"id",@"1",@"tid",nil];
    return parameters;
}

@end

//
//  FetchExpressRequestParameter.m
//  zhongying
//
//  Created by lik on 14-3-24.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import "FetchExpressRequestParameter.h"

@implementation FetchExpressRequestParameter

@synthesize userId, password, communityId, goodId;

- (NSDictionary *)convertToRequest
{
    NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys:self.userId,@"uid",self.password,@"password",self.communityId,@"cid",self.goodId,@"id",nil];
    return parameters;
}

@end

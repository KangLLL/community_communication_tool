//
//  AddEWMRequestParameter.m
//  zhongying
//
//  Created by lik on 14-3-24.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import "AddEWMRequestParameter.h"

@implementation AddEWMRequestParameter

@synthesize userId, password, communityId, buildNo, floorNo, roomNo;

- (NSDictionary *)convertToRequest
{
    NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys:self.userId,@"uid",self.password,@"password",self.communityId,@"cid",self.buildNo,@"build",self.floorNo,@"floor",self.roomNo,@"num",nil];
    return parameters;
}

@end

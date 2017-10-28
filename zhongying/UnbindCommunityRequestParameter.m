//
//  DeleteHouseRequestParameter.m
//  zhongying
//
//  Created by lik on 14-3-24.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import "UnbindCommunityRequestParameter.h"

@implementation UnbindCommunityRequestParameter

@synthesize communityId, buildNo, floorNo, roomNo;

- (NSDictionary *)convertToRequest
{
    NSMutableDictionary *result = [NSMutableDictionary dictionaryWithDictionary:[super getCommonDictionary]];
    
    NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys:self.communityId,@"cid",self.buildNo,@"build",self.floorNo,@"floor",self.roomNo,@"num",nil];
    
    [result addEntriesFromDictionary:parameters];
    return result;
}

@end

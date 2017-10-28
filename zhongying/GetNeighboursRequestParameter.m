//
//  GetNeighboursRequestParameter.m
//  zhongying
//
//  Created by lik on 14-4-10.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import "GetNeighboursRequestParameter.h"

@implementation GetNeighboursRequestParameter

@synthesize communityId, buildNo, floorNo, roomNo;

- (NSDictionary *)convertToRequest
{
    NSMutableDictionary *result = [NSMutableDictionary dictionaryWithDictionary:[super getCommonDictionary]];
    
    [result setValue:self.communityId forKey:@"cid"];
    
    if(self.buildNo != nil){
        [result setValue:self.buildNo forKey:@"build"];
    }
    if(self.floorNo != nil){
        [result setValue:self.floorNo forKey:@"floor"];
    }
    if(self.roomNo != nil){
        [result setValue:self.roomNo forKey:@"num"];
    }
    return result;
}

@end

//
//  NeighbourParameter.m
//  zhongying
//
//  Created by lik on 14-4-10.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import "NeighbourParameter.h"

@implementation NeighbourParameter

@synthesize peopleId, buildNo, floorNo, roomNo, name, messageCount;

- (void)initialFromDictionaryResponse:(NSDictionary *)response
{
    self.peopleId = [response objectForKey:@"usid"];
    self.buildNo = [response objectForKey:@"build"];
    self.floorNo = [response objectForKey:@"floor"];
    self.roomNo = [response objectForKey:@"num"];
    if([response objectForKey:@"name"] != [NSNull null]){
        self.name = [response objectForKey:@"name"];
    }
    else{
        self.name = @"";
    }
    self.messageCount = [response objectForKey:@"msgnum"];
}

@end

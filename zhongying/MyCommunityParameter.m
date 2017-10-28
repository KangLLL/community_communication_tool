//
//  MyCommunityParameter.m
//  zhongying
//
//  Created by lik on 14-3-21.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import "MyCommunityParameter.h"

@implementation MyCommunityParameter

@synthesize communityName,communityId,buildingNo,floorNo,roomNo,communityPeopleCount,twoDimensionCodeStatus,city,myComplaintCount,myRepairCount, ownerName;

- (void)initialFromDictionaryResponse:(NSDictionary *)response
{
    self.communityName = [response objectForKey:@"name"];
    self.communityId = [response objectForKey:@"id"];
    self.buildingNo = [response objectForKey:@"build"];
    self.floorNo = [response objectForKey:@"floor"];
    self.roomNo = [response objectForKey:@"num"];
    self.ownerName = [response objectForKey:@"username"];
    self.communityPeopleCount = [response objectForKey:@"people"];
    self.twoDimensionCodeStatus = [[response objectForKey:@"ewm"] intValue];
    self.city = [response objectForKey:@"city"];
    self.myComplaintCount = [response objectForKey:@"tsnum"];
    self.myRepairCount = [response objectForKey:@"bxnum"];
    //self.myNeighbourCount = [response objectForKey:@"neighbour"];
}

@end

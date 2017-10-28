//
//  MyHouseParameter.m
//  zhongying
//
//  Created by lik on 14-3-24.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import "MyHouseParameter.h"

@implementation MyHouseParameter

@synthesize messageId, userId, communityName, contactName, contactPhone, title, rentType, price, time, size, payType, totalRoom, totalLobby, totalToilet, floorNo, totalFloor, description;

- (void)initialFromDictionaryResponse:(NSDictionary *)response
{
    self.messageId = [response objectForKey:@"id"];
    self.userId = [response objectForKey:@"user_id"];
    self.communityName = [response objectForKey:@"house_area"];
    self.contactName = [response objectForKey:@"house_owner"];
    self.contactPhone = [response objectForKey:@"house_tel"];
    self.title = [response objectForKey:@"house_title"];
    self.rentType = [response objectForKey:@"rent_type"];
    self.price = [[response objectForKey:@"rent_money"] floatValue];
    self.time = [response objectForKey:@"add_time"];
    self.size = [response objectForKey:@"mj"];
    self.payType = [response objectForKey:@"money_type"];
    self.totalRoom = [[response objectForKey:@"shi"] intValue];
    self.totalLobby = [[response objectForKey:@"ting"] intValue];
    self.totalToilet = [[response objectForKey:@"wei"] intValue];
    self.floorNo = [response objectForKey:@"floor"];
    self.totalFloor = [response objectForKey:@"total_floor"];
    self.description = [response objectForKey:@"house_desc"];
}

@end

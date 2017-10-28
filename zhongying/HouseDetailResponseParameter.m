//
//  HouseDetailParameter.m
//  zhongying
//
//  Created by lik on 14-3-24.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import "HouseDetailResponseParameter.h"

@implementation HouseDetailResponseParameter

@synthesize tile, contactName, contactPhone, rentType, price, time, description, size, payType, totalLobby, totalRoom, totalToilet, floorNo, totalFloor, image1, image2, image3;

- (void)initialFromDictionaryResponse:(NSDictionary *)response
{
    self.tile = [response objectForKey:@"house_title"];
    self.contactName = [response objectForKey:@"house_owner"];
    self.contactPhone = [response objectForKey:@"house_tel"];
    self.rentType = [response objectForKey:@"rent_type"];
    self.price = [response objectForKey:@"rent_money"];
    self.time = [response objectForKey:@"add_time"];
    self.description = [response objectForKey:@"house_desc"];
    self.size = [response objectForKey:@"mj"];
    self.payType = [response objectForKey:@"money_type"];
    self.totalLobby = [[response objectForKey:@"ting"] intValue];
    self.totalRoom = [[response objectForKey:@"shi"] intValue];
    self.totalToilet = [[response objectForKey:@"wei"] intValue];
    self.floorNo = [response objectForKey:@"floor"];
    self.totalFloor = [response objectForKey:@"total_floor"];
    if([response objectForKey:@"house_img"] != [NSNull null] && [[response objectForKey:@"house_img"] length] > 0){
        self.image1 = [response objectForKey:@"house_img"];
    }
    if([response objectForKey:@"house_img2"] != [NSNull null] && [[response objectForKey:@"house_img2"] length] > 0){
        self.image2 = [response objectForKey:@"house_img2"];
    }
    if([response objectForKey:@"house_img3"] != [NSNull null] && [[response objectForKey:@"house_img3"] length] > 0){
        self.image3 = [response objectForKey:@"house_img3"];
    }
}

@end

//
//  ExpressParameter.m
//  zhongying
//
//  Created by lik on 14-3-22.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import "ExpressParameter.h"

@implementation ExpressParameter

@synthesize goodId, receivedTime, buildNo, floorNo, roomNo, name, quantity, expressCrop, arrivedTime, getDescription, communityId, status;

- (void)initialFromDictionaryResponse:(NSDictionary *)response
{
    self.goodId = [response objectForKey:@"goods_id"];
    self.receivedTime = [response objectForKey:@"take_time"];
    self.buildNo = [response objectForKey:@"build"];
    self.floorNo = [response objectForKey:@"floor"];
    self.roomNo = [response objectForKey:@"num"];
    self.name = [response objectForKey:@"name"];
    self.quantity = [[response objectForKey:@"kd_num"] intValue];
    self.expressCrop = [response objectForKey:@"kd_company"];
    self.arrivedTime = [response objectForKey:@"reach_time"];
    self.getDescription = [response objectForKey:@"take_time"];
    self.communityId = [response objectForKey:@"comm_id"];
    self.status = [[response objectForKey:@"is_pay"] intValue];
}

@end

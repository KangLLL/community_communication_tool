//
//  ParkingParameter.m
//  zhongying
//
//  Created by lik on 14-3-22.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import "ParkingParameter.h"

@implementation ParkingParameter

@synthesize billId, buildNo, floorNo, roomNo, name, expirationTime, price, cardNo, carNo;

- (void)initialFromDictionaryResponse:(NSDictionary *)response
{
    self.billId = [response objectForKey:@"id"];
    self.buildNo = [response objectForKey:@"build"];
    self.floorNo = [response objectForKey:@"floor"];
    self.roomNo = [response objectForKey:@"num"];
    self.name = [response objectForKey:@"name"];
    self.expirationTime = [response objectForKey:@"month"];
    self.price = [[response objectForKey:@"money"] floatValue];
    self.cardNo = [response objectForKey:@"card"];
    self.carNo = [response objectForKey:@"car_num"];
}

@end

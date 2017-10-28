//
//  MyParkingParameter.m
//  zhongying
//
//  Created by lik on 14-3-25.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import "MyParkingParameter.h"

@implementation MyParkingParameter

@synthesize billId, buildNo, floorNo, roomNo, payerName, expirationTime, totalFee, cardNo,carNo, time;

- (void)initialFromDictionaryResponse:(NSDictionary *)response
{
    self.billId = [response objectForKey:@"id"];
    self.buildNo = [response objectForKey:@"build"];
    self.floorNo = [response objectForKey:@"floor"];
    self.roomNo = [response objectForKey:@"num"];
    self.payerName = [response objectForKey:@"name"];
    self.expirationTime = [response objectForKey:@"month"];
    self.totalFee = [[response objectForKey:@"money"] floatValue];
    self.cardNo = [response objectForKey:@"card"];
    self.carNo = [response objectForKey:@"car_num"];
    self.time = [response objectForKey:@"pay_time"];
   
}

@end

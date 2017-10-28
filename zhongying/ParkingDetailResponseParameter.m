//
//  ParkingDetailResponseParameter.m
//  zhongying
//
//  Created by lik on 14-3-24.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import "ParkingDetailResponseParameter.h"
#import "PayParameter.h"

@implementation ParkingDetailResponseParameter

@synthesize billId, buildNo, floorNo, roomNo, ownerName, expirationTime, price, cardNo, carNo, remainingMoney, pays;

- (void)initialFromDictionaryResponse:(NSDictionary *)response
{
    self.billId = [response objectForKey:@"id"];
    self.buildNo = [response objectForKey:@"build"];
    self.floorNo = [response objectForKey:@"floor"];
    self.roomNo = [response objectForKey:@"num"];
    self.ownerName = [response objectForKey:@"name"];
    self.expirationTime = [response objectForKey:@"month"];
    self.price = [response objectForKey:@"money"];
    self.cardNo = [response objectForKey:@"card"];
    self.carNo = [response objectForKey:@"car_num"];
    self.brand = [response objectForKey:@"car_brand"];
    self.remainingMoney = [[response objectForKey:@"mymoney"] floatValue];
    
    NSMutableArray *temp = [NSMutableArray array];
    NSArray *array = [response objectForKey:@"pay_type"];
    for (NSDictionary *dict in array) {
        PayParameter *param = [[PayParameter alloc] init];
        [param initialFromDictionaryResponse:dict];
        [temp addObject:param];
    }
    self.pays = temp;
}

@end

//
//  MyUtilitiesParameter.m
//  zhongying
//
//  Created by lik on 14-3-25.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import "MyUtilitiesParameter.h"

@implementation MyUtilitiesParameter

@synthesize billId, buildNo, floorNo, roomNo, payerName, time, totalFee;

- (void)initialFromDictionaryResponse:(NSDictionary *)response
{
    self.billId = [response objectForKey:@"id"];
    self.buildNo = [response objectForKey:@"build"];
    self.floorNo = [response objectForKey:@"floor"];
    self.roomNo = [response objectForKey:@"num"];
    self.payerName = [response objectForKey:@"name"];
    self.time = [response objectForKey:@"times"];
    self.totalFee = [[response objectForKey:@"money"] floatValue];
}

@end

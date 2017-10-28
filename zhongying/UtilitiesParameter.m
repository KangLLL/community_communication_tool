//
//  UtilitiesParameter.m
//  zhongying
//
//  Created by lik on 14-3-22.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import "UtilitiesParameter.h"

@implementation UtilitiesParameter

@synthesize billId, buildNo, floorNo, roomNo, name, time, totalFee, status;

- (void)initialFromDictionaryResponse:(NSDictionary *)response
{
    self.billId = [response objectForKey:@"id"];
    self.buildNo = [response objectForKey:@"build"];
    self.floorNo = [response objectForKey:@"floor"];
    self.roomNo = [response objectForKey:@"num"];
    self.name = [response objectForKey:@"name"];
    self.time = [response objectForKey:@"times"];
    self.totalFee = [response objectForKey:@"money"];
    self.status = [[response objectForKey:@"is_pay"] intValue];
}

@end

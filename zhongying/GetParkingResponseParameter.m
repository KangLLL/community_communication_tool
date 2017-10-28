//
//  GetParkingResponseParameter.m
//  zhongying
//
//  Created by lik on 14-3-22.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import "GetParkingResponseParameter.h"
#import "ParkingParameter.h"

@implementation GetParkingResponseParameter

@synthesize parkingBills;

- (void)initialFromArrayResponse:(NSArray *)response
{
    NSMutableArray *temp = [NSMutableArray array];
    for (NSDictionary *dict in response) {
        ParkingParameter *param = [[ParkingParameter alloc] init];
        [param initialFromDictionaryResponse:dict];
        [temp addObject:param];
    }
    self.parkingBills = temp;
}

@end

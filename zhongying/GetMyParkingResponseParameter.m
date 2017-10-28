//
//  GetMyParkingResponseParameter.m
//  zhongying
//
//  Created by lik on 14-3-25.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import "GetMyParkingResponseParameter.h"
#import "MyParkingParameter.h"

@implementation GetMyParkingResponseParameter

@synthesize myParkings;

- (void)initialFromArrayResponse:(NSArray *)response
{
    NSMutableArray *temp = [NSMutableArray array];
    for (NSDictionary *dict in response) {
        MyParkingParameter *param = [[MyParkingParameter alloc] init];
        [param initialFromDictionaryResponse:dict];
        [temp addObject:param];
    }
    self.myParkings = temp;
}

@end

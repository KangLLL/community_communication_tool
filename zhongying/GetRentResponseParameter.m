//
//  GetRentResponseParameter.m
//  zhongying
//
//  Created by lik on 14-3-24.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import "GetRentResponseParameter.h"
#import "HouseParameter.h"

@implementation GetRentResponseParameter

@synthesize houses;

- (void)initialFromArrayResponse:(NSArray *)response
{
    NSMutableArray *temp = [NSMutableArray array];
    for (NSDictionary *dict in response) {
        HouseParameter *param = [[HouseParameter alloc] init];
        [param initialFromDictionaryResponse:dict];
        [temp addObject:param];
    }
    self.houses = temp;
}

@end

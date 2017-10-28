//
//  GetMyRentResponseParameter.m
//  zhongying
//
//  Created by lik on 14-3-24.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import "GetMyRentResponseParameter.h"
#import "MyHouseParameter.h"

@implementation GetMyRentResponseParameter

@synthesize houses;

- (void)initialFromArrayResponse:(NSArray *)response
{
    NSMutableArray *temp = [NSMutableArray array];
    for (NSDictionary *dict in response) {
        MyHouseParameter *param = [[MyHouseParameter alloc] init];
        [param initialFromDictionaryResponse:dict];
        [temp addObject:param];
    }
    self.houses = temp;
}

@end

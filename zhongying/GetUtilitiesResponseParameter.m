//
//  GetUtilitiesResponseParameter.m
//  zhongying
//
//  Created by lik on 14-3-22.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import "GetUtilitiesResponseParameter.h"
#import "UtilitiesParameter.h"

@implementation GetUtilitiesResponseParameter

@synthesize utilitiesBills;

- (void)initialFromArrayResponse:(NSArray *)response
{
    NSMutableArray *temp = [NSMutableArray array];
    for (NSDictionary *dict in response) {
        UtilitiesParameter *param = [[UtilitiesParameter alloc] init];
        [param initialFromDictionaryResponse:dict];
        [temp addObject:param];
    }
    self.utilitiesBills = temp;
}

@end

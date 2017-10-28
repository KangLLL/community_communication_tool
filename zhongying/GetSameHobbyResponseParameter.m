//
//  GetSameHobbyResponseParameter.m
//  zhongying
//
//  Created by lik on 14-4-8.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import "GetSameHobbyResponseParameter.h"
#import "HobbyPeopleParameter.h"

@implementation GetSameHobbyResponseParameter

@synthesize sameHobbyPeoples;

- (void)initialFromArrayResponse:(NSArray *)response
{
    NSMutableArray *temp = [NSMutableArray array];
    for (NSDictionary *dict in response) {
        HobbyPeopleParameter *param = [[HobbyPeopleParameter alloc] init];
        [param initialFromDictionaryResponse:dict];
        [temp addObject:param];
    }
    self.sameHobbyPeoples = temp;
}

@end

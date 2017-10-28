//
//  GetHobbiesResponseParameter.m
//  zhongying
//
//  Created by lik on 14-4-8.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import "GetHobbiesResponseParameter.h"
#import "HobbyParameter.h"

@implementation GetHobbiesResponseParameter

@synthesize hobbies;

- (void)initialFromArrayResponse:(NSArray *)response
{
    NSMutableArray *temp = [NSMutableArray array];
    for (NSDictionary *dict in response) {
        HobbyParameter *param = [[HobbyParameter alloc] init];
        [param initialFromDictionaryResponse:dict];
        [temp addObject:param];
    }
    self.hobbies = temp;
}

@end
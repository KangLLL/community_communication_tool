//
//  BuildParameter.m
//  zhongying
//
//  Created by lik on 14-3-25.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import "BuildParameter.h"
#import "FloorParameter.h"

@implementation BuildParameter

@synthesize buildNo, floors;

- (void)initialFromDictionaryResponse:(NSDictionary *)response
{
    self.buildNo = [response objectForKey:@"build"];
    NSArray *array = [response objectForKey:@"contain1"];
    NSMutableArray *temp = [NSMutableArray array];
    for (NSDictionary *dict in array) {
        FloorParameter *floor = [[FloorParameter alloc] init];
        [floor initialFromDictionaryResponse:dict];
        [temp addObject:floor];
    }
    self.floors = temp;
}


@end

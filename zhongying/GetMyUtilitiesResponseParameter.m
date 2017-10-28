//
//  GetMyUtilitiesResponseParameter.m
//  zhongying
//
//  Created by lik on 14-3-25.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import "GetMyUtilitiesResponseParameter.h"
#import "MyUtilitiesParameter.h"

@implementation GetMyUtilitiesResponseParameter

@synthesize myUtilities;

- (void)initialFromArrayResponse:(NSArray *)response
{
    NSMutableArray *temp = [NSMutableArray array];
    for (NSDictionary *dict in response) {
        MyUtilitiesParameter *param = [[MyUtilitiesParameter alloc] init];
        [param initialFromDictionaryResponse:dict];
        [temp addObject:param];
    }
    self.myUtilities = temp;
}

@end

//
//  GetExpressResponseParameter.m
//  zhongying
//
//  Created by lik on 14-3-22.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import "GetExpressResponseParameter.h"
#import "ExpressParameter.h"

@implementation GetExpressResponseParameter

@synthesize expresses;

- (void)initialFromArrayResponse:(NSArray *)response
{
    NSMutableArray *temp = [NSMutableArray array];
    for (NSDictionary *dict in response) {
        ExpressParameter *param = [[ExpressParameter alloc] init];
        [param initialFromDictionaryResponse:dict];
        [temp addObject:param];
    }
    self.expresses = temp;
}

@end

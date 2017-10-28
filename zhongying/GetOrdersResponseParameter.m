//
//  GetOrdersResponseParameter.m
//  zhongying
//
//  Created by lk on 14-4-23.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import "GetOrdersResponseParameter.h"
#import "OrderParameter.h"

@implementation GetOrdersResponseParameter

- (void)initialFromArrayResponse:(NSArray *)response
{
    NSMutableArray *temp = [NSMutableArray array];
    for (NSDictionary *dict in response) {
        OrderParameter *param = [[OrderParameter alloc] init];
        [param initialFromDictionaryResponse:dict];
        [temp addObject:param];
    }
    self.orders = temp;
}

@end

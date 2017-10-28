//
//  GetMoneyLogResponseParameter.m
//  zhongying
//
//  Created by lk on 14-4-25.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import "GetMoneyLogResponseParameter.h"
#import "MoneyLogParameter.h"

@implementation GetMoneyLogResponseParameter

@synthesize logs;

- (void)initialFromArrayResponse:(NSArray *)response
{
    NSMutableArray *temp = [NSMutableArray array];
    for (NSDictionary *dict in response) {
        MoneyLogParameter *param = [[MoneyLogParameter alloc] init];
        [param initialFromDictionaryResponse:dict];
        [temp addObject:param];
    }
    self.logs = temp;
}


@end

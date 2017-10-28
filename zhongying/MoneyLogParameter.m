//
//  MoneyLogParameter.m
//  zhongying
//
//  Created by lk on 14-4-25.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import "MoneyLogParameter.h"

@implementation MoneyLogParameter

@synthesize time, money, tips, remainingMoney;

- (void)initialFromDictionaryResponse:(NSDictionary *)response
{
    self.time = [response objectForKey:@"times"];
    self.money = [response objectForKey:@"money"];
    self.tips = [response objectForKey:@"content"];
    self.remainingMoney = [response objectForKey:@"balance"];
}

@end

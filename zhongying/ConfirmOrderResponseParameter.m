//
//  ConfirmOrderResponseParameter.m
//  zhongying
//
//  Created by lk on 14-4-23.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import "ConfirmOrderResponseParameter.h"
#import "AddressParameter.h"
#import "ShipParameter.h"
#import "PayParameter.h"

@implementation ConfirmOrderResponseParameter

@synthesize addresses, pays, ships, remainingMoney;

- (void)initialFromDictionaryResponse:(NSDictionary *)response
{
    NSMutableArray *temp = [NSMutableArray array];
    NSArray *array = [response objectForKey:@"address"];
    for (NSDictionary *dict in array) {
        AddressParameter *param = [[AddressParameter alloc] init];
        [param initialFromDictionaryResponse:dict];
        [temp addObject:param];
    }
    self.addresses = temp;
    
    temp = [NSMutableArray array];
    array = [response objectForKey:@"pay_type"];
    for (NSDictionary *dict in array) {
        PayParameter *param = [[PayParameter alloc] init];
        [param initialFromDictionaryResponse:dict];
        [temp addObject:param];
    }
    self.pays = temp;
    
    temp = [NSMutableArray array];
    array = [response objectForKey:@"ship"];
    for (NSDictionary *dict in array) {
        ShipParameter *param = [[ShipParameter alloc] init];
        [param initialFromDictionaryResponse:dict];
        [temp addObject:param];
    }
    self.ships = temp;
    
    self.remainingMoney = [[response objectForKey:@"mymoney"] floatValue];

}

@end

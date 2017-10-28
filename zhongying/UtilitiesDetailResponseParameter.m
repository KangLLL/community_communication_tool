//
//  UtilitiesDetailResponseParameter.m
//  zhongying
//
//  Created by lik on 14-3-24.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import "UtilitiesDetailResponseParameter.h"
#import "PayParameter.h"

@implementation UtilitiesDetailResponseParameter

@synthesize propertyFee, waterFee, electricityFee, gasFee, shareFee, payerName, payTime, remainingMoney, pays;

- (void)initialFromDictionaryResponse:(NSDictionary *)response
{
    self.propertyFee = [response objectForKey:@"wgf"];
    self.waterFee = [response objectForKey:@"sf"];
    self.electricityFee = [response objectForKey:@"df"];
    self.gasFee = [response objectForKey:@"qf"];
    self.shareFee = [response objectForKey:@"gt"];
    self.payerName = [response objectForKey:@"pname"];
    self.payTime = [response objectForKey:@"pay_time"];
    self.remainingMoney = [response objectForKey:@"mymoney"];
    
    NSMutableArray *temp = [NSMutableArray array];
    NSArray *array = [response objectForKey:@"pay_type"];
    for (NSDictionary *dict in array) {
        PayParameter *param = [[PayParameter alloc] init];
        [param initialFromDictionaryResponse:dict];
        [temp addObject:param];
    }
    self.pays = temp;
}

@end

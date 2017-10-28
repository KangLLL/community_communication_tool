//
//  GetAddressesResponseParameter.m
//  zhongying
//
//  Created by lk on 14-4-14.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import "GetAddressesResponseParameter.h"
#import "AddressParameter.h"

@implementation GetAddressesResponseParameter

@synthesize addresses;

- (void)initialFromArrayResponse:(NSArray *)response
{
    NSMutableArray *temp = [NSMutableArray array];
    for (NSDictionary *dict in response) {
        AddressParameter *param = [[AddressParameter alloc] init];
        [param initialFromDictionaryResponse:dict];
        [temp addObject:param];
    }
    self.addresses = temp;
}

@end

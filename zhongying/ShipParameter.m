//
//  ShipParameter.m
//  zhongying
//
//  Created by lk on 14-4-23.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import "ShipParameter.h"

@implementation ShipParameter

@synthesize shipId, shipName, shipPrice, insurePrice;

- (void)initialFromDictionaryResponse:(NSDictionary *)response
{
    self.shipId = [response objectForKey:@"s_id"];
    self.shipName = [response objectForKey:@"s_name"];
    if([[response allKeys] containsObject:@"s_price"]){
        self.shipPrice = [response objectForKey:@"s_price"];
    }
    else{
        self.shipPrice = @"0";
    }
    self.insurePrice = [response objectForKey:@"s_baojia"];
}

@end

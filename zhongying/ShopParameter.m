//
//  ShopParameter.m
//  zhongying
//
//  Created by lk on 14-4-21.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import "ShopParameter.h"

@implementation ShopParameter

@synthesize shopId, shopName, address, phone, mapX, mayY, imageUrl;

- (void)initialFromDictionaryResponse:(NSDictionary *)response
{
    self.shopId = [response objectForKey:@"id"];
    self.shopName = [response objectForKey:@"com_name"];
    self.address = [response objectForKey:@"address"];
    self.phone = [response objectForKey:@"tel"];
    if([response objectForKey:@"map_x"] != [NSNull null]){
        self.mapX = [[response objectForKey:@"map_x"] floatValue];
    }
    if([response objectForKey:@"map_y"] != [NSNull null]){
        self.mayY = [[response objectForKey:@"map_y"] floatValue];
    }
    self.imageUrl = [response objectForKey:@"pic"];
}

@end

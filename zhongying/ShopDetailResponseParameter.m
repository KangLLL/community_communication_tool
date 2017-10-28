//
//  GetShopDetailResponseParameter.m
//  zhongying
//
//  Created by lk on 14-4-21.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import "ShopDetailResponseParameter.h"

@implementation ShopDetailResponseParameter

@synthesize shopName, address, phone, mapX, mapY, area, businessHour, detailUrl, primaryCategory, subCategory;

- (void)initialFromDictionaryResponse:(NSDictionary *)response
{
    self.shopName = [response objectForKey:@"com_name"];
    self.address = [response objectForKey:@"address"];
    self.phone = [response objectForKey:@"tel"];
    self.mapX = [response objectForKey:@"map_x"];
    self.mapY = [response objectForKey:@"map_y"];
    self.area = [response objectForKey:@"area"];
    self.businessHour = [response objectForKey:@"opentime"];
    self.detailUrl = [response objectForKey:@"url"];
    self.primaryCategory = [response objectForKey:@"fcata"];
    self.subCategory = [response objectForKey:@"scata"];
}

@end

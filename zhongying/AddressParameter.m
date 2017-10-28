//
//  AddressParameter.m
//  zhongying
//
//  Created by lk on 14-4-14.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import "AddressParameter.h"

@implementation AddressParameter

@synthesize addressId, name, address, phone, zipCode, provinceId, provinceName, cityId, cityName, districtId, districtName;

- (void)initialFromDictionaryResponse:(NSDictionary *)response
{
    if([[response allKeys] containsObject:@"id"]){
        self.addressId = [response objectForKey:@"id"];
    }
    else if([[response allKeys] containsObject:@"add_id"]){
        self.addressId = [response objectForKey:@"add_id"];
    }
    self.name = [response objectForKey:@"name"];
    self.address = [response objectForKey:@"address"];
    self.phone = [response objectForKey:@"tel"];
    self.zipCode = [response objectForKey:@"zipcode"];
    self.provinceId = [[response objectForKey:@"province"] intValue];
    self.provinceName = [response objectForKey:@"p_name"];
    self.cityId = [[response objectForKey:@"city"] intValue];
    self.cityName = [response objectForKey:@"c_name"];
    self.districtId = [[response objectForKey:@"district"] intValue];
    self.districtName = [response objectForKey:@"d_name"];
}

@end

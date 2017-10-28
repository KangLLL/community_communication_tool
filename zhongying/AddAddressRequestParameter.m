//
//  AddAddressRequestParameter.m
//  zhongying
//
//  Created by lk on 14-4-14.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import "AddAddressRequestParameter.h"

@implementation AddAddressRequestParameter

@synthesize name, phone, address, provinceId, cityId, districtId, zipCode;

- (NSDictionary *)convertToRequest
{
    NSMutableDictionary *result = [NSMutableDictionary dictionaryWithDictionary:[super getCommonDictionary]];
    
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:self.name,@"name",self.phone,@"tel",self.address,@"address",[NSString stringWithFormat:@"%d", self.provinceId],@"province",[NSString stringWithFormat:@"%d", self.cityId],@"city",[NSString stringWithFormat:@"%d", self.districtId],@"district",self.zipCode,@"code",nil];
    
    [result addEntriesFromDictionary:dict];
    return result;
}
@end

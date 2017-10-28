//
//  GetShopsRequestParameter.m
//  zhongying
//
//  Created by lk on 14-4-21.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import "GetShopsRequestParameter.h"

@implementation GetShopsRequestParameter

@synthesize categoryId, communityId, provinceId, cityId, districtId, page, pageSize;

- (NSDictionary *)convertToRequest
{
    NSMutableDictionary *result = [NSMutableDictionary dictionaryWithDictionary:[super getCommonDictionary]];
    
    if(self.communityId != nil){
        [result setObject:self.communityId forKey:@"cid"];
    }
    else{
        if(self.categoryId != nil){
            [result setObject:self.categoryId forKey:@"id"];
        }
        if(self.districtId != nil){
            [result setObject:self.districtId forKey:@"district"];
        }
        if(self.cityId != nil){
            [result setObject:self.cityId forKey:@"city"];
        }
        if(self.provinceId != nil){
            [result setObject:self.provinceId forKey:@"province"];
        }
    }
   
    return result;
}
         
@end

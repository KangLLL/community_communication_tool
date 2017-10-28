//
//  GetCommunityRequestParameter.m
//  zhongying
//
//  Created by lik on 14-3-24.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import "GetCommunityRequestParameter.h"

@implementation GetCommunityRequestParameter

@synthesize provinceId, cityId, districtId;

- (NSDictionary *)convertToRequest
{
    NSMutableDictionary *result = [NSMutableDictionary dictionaryWithDictionary:[super getCommonDictionary]];
    
    NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys:self.provinceId,@"province",self.cityId,@"city",self.districtId,@"district",nil];
    [result setValuesForKeysWithDictionary:parameters];
    
    return result;
}

@end

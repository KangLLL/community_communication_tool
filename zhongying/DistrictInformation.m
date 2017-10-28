//
//  DistrictInformation.m
//  zhongying
//
//  Created by lik on 14-3-25.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import "DistrictInformation.h"
#import "RegionInformation.h"

static DistrictInformation *sigleton;

@implementation DistrictInformation

 
+ (DistrictInformation *)instance
{
    if(sigleton == nil){
        sigleton = [[DistrictInformation alloc] init];
    }
    return sigleton;
}


- (void)initialRegions
{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"parentId == 1"];
    self.provinces = [self.regions filteredArrayUsingPredicate:predicate];
}

- (NSArray *)getProvinces
{
    return self.provinces;
}

- (NSArray *)getCitys:(int)provinceId
{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"regionId == %d",provinceId];
    RegionInformation *province = [[self.provinces filteredArrayUsingPredicate:predicate] firstObject];
    if(province.children == nil){
        predicate = [NSPredicate predicateWithFormat:@"parentId == %d",provinceId];
        province.children = [self.regions filteredArrayUsingPredicate:predicate];
    }
    return province.children;
}

- (NSArray *)getDistricts:(int)cityId
{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"regionId == %d",cityId];
    RegionInformation *city = [[self.regions filteredArrayUsingPredicate:predicate] firstObject];
    if(city.children == nil){
        predicate = [NSPredicate predicateWithFormat:@"parentId == %d",cityId];
        city.children = [self.regions filteredArrayUsingPredicate:predicate];
    }
    return city.children;
}
@end

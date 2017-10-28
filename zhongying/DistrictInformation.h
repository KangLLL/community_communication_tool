//
//  DistrictInformation.h
//  zhongying
//
//  Created by lik on 14-3-25.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DistrictInformation : NSObject

@property NSArray *regions;
@property NSArray *provinces;

+ (DistrictInformation *)instance;
- (void)initialRegions;
- (NSArray *)getProvinces;
- (NSArray *)getCitys:(int)provinceId;
- (NSArray *)getDistricts:(int)cityId;

@end

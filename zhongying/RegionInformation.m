//
//  DistrictInformation.m
//  zhongying
//
//  Created by lik on 14-3-25.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import "RegionInformation.h"

@implementation RegionInformation

@synthesize regionId, parentId, regionName, children;

- (instancetype)initWithDict:(NSDictionary *)dict
{
    if(self = [super init]){
        self.regionId = [[dict objectForKey:@"region_id"] intValue];
        self.parentId = [[dict objectForKey:@"parent_id"] intValue];
        self.regionName = [dict objectForKey:@"region_name"];
        return self;
    }
    return nil;
}

@end

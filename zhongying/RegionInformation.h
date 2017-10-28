//
//  DistrictInformation.h
//  zhongying
//
//  Created by lik on 14-3-25.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RegionInformation : NSObject

@property (assign) int regionId;
@property (assign) int parentId;
@property (strong) NSString *regionName;

@property (strong) NSArray *children;

- (instancetype)initWithDict:(NSDictionary *)dict;

@end

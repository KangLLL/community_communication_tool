//
//  CommunityParameter.h
//  zhongying
//
//  Created by lik on 14-3-19.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ResponseParameter.h"

@interface CommunityParameter : NSObject<ResponseParameter>

@property (strong) NSString *communityName;
@property (strong) NSString *communityId;
@property (strong) NSString *city;

@end

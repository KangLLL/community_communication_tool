//
//  CommunitiInfoParameter.h
//  zhongying
//
//  Created by lik on 14-3-24.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ResponseParameter.h"

@interface CommunityInfoParameter : NSObject<ResponseParameter>

@property (strong) NSString *communityId;
@property (strong) NSString *communityName;

@end

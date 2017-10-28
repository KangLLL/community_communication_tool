//
//  CommunityDetailRequestParameter.h
//  zhongying
//
//  Created by lk on 14-5-24.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import "CommonRequestParameter.h"
#import "RequestParameter.h"

@interface CommunityDetailRequestParameter : CommonRequestParameter<RequestParameter>

@property (strong) NSString* communityId;

@end

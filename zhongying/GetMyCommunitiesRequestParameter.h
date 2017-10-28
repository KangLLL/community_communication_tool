//
//  GetMyCommunitiesRequestParameter.h
//  zhongying
//
//  Created by lik on 14-3-21.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import "CommonRequestParameter.h"
#import "RequestParameter.h"

@interface GetMyCommunitiesRequestParameter : CommonRequestParameter<RequestParameter>

@property (assign) BOOL isUserCenter;

@end

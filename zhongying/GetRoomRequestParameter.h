//
//  GetRoomRequestParameter.h
//  zhongying
//
//  Created by lik on 14-3-24.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import "CommonRequestParameter.h"
#import "RequestParameter.h"

@interface GetRoomRequestParameter : CommonRequestParameter<RequestParameter>

@property (strong) NSString *communityId;

@end

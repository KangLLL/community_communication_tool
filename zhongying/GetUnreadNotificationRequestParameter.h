//
//  GetUnreadMessageRequestParameter.h
//  zhongying
//
//  Created by lk on 14-4-15.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import "CommonRequestParameter.h"
#import "RequestParameter.h"

@interface GetUnreadNotificationRequestParameter : CommonRequestParameter<RequestParameter>

@property (strong) NSString *communityId;

@end

//
//  GroupDetailResponseParameter.h
//  zhongying
//
//  Created by lk on 14-4-20.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import "CommonRequestParameter.h"
#import "RequestParameter.h"

@interface GroupDetailRequestParameter : CommonRequestParameter<RequestParameter>

@property (strong) NSString *groupId;

@end

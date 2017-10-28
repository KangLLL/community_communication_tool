//
//  AddGroupOrderRequestParameter.h
//  zhongying
//
//  Created by lk on 14-4-23.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import "AddOrderRequestParameter.h"
#import "RequestParameter.h"

@interface AddGroupOrderRequestParameter : AddOrderRequestParameter<RequestParameter>

@property (strong) NSString *groupId;

@end

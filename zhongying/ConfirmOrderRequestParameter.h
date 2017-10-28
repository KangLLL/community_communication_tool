//
//  ConfirmOrderRequestParameter.h
//  zhongying
//
//  Created by lk on 14-4-23.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import "CommonRequestParameter.h"
#import "RequestParameter.h"

@interface ConfirmOrderRequestParameter : CommonRequestParameter<RequestParameter>

@property (strong) NSString *productId;
@property (assign) int count;
@property (strong) NSString *attribute;
@property (assign) int limitRestrict;
@property (strong) NSString *groupId;
@property (assign) BOOL isGroup;

@end

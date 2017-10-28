//
//  ReserveDetailRequestParameter.h
//  zhongying
//
//  Created by lk on 14-4-24.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import "CommonRequestParameter.h"
#import "RequestParameter.h"

@interface ReserveDetailRequestParameter : CommonRequestParameter<RequestParameter>

@property (strong) NSString *reserveId;

@end

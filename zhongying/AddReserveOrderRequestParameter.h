//
//  AddReserveOrderRequestParameter.h
//  zhongying
//
//  Created by lk on 14-4-24.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import "AddOrderRequestParameter.h"
#import "RequestParameter.h"

@interface AddReserveOrderRequestParameter : AddOrderRequestParameter<RequestParameter>

@property (strong) NSString *reserveId;

@end

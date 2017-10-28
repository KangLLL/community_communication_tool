//
//  DeleteOrderRequestParameter.h
//  zhongying
//
//  Created by lk on 14-4-23.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import "CommonRequestParameter.h"
#import "RequestParameter.h"

@interface DeleteOrderRequestParameter : CommonRequestParameter<RequestParameter>

@property (strong) NSString *orderId;

@end

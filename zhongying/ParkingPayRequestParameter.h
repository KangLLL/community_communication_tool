//
//  ParkingPayRequestParameter.h
//  zhongying
//
//  Created by lk on 14-4-19.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import "PayRequestParameter.h"
#import "RequestParameter.h"

@interface ParkingPayRequestParameter : PayRequestParameter<RequestParameter>

@property (assign) int month;

@end

//
//  FetchExpressRequestParameter.h
//  zhongying
//
//  Created by lik on 14-3-24.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RequestParameter.h"

@interface FetchExpressRequestParameter : NSObject<RequestParameter>

@property (strong) NSString *userId;
@property (strong) NSString *password;
@property (strong) NSString *communityId;
@property (strong) NSString *goodId;

@end
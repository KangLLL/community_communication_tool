//
//  LoginRequestParameter.h
//  zhongying
//
//  Created by lik on 14-3-19.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RequestParameter.h"

@interface LoginRequestParameter : NSObject<RequestParameter>

@property (strong) NSString *name;
@property (strong) NSString *password;

@end

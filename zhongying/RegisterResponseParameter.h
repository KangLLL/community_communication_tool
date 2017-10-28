//
//  RegisterResponseParameter.h
//  zhongying
//
//  Created by lik on 14-3-19.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ResponseParameter.h"

@interface RegisterResponseParameter : NSObject<ResponseParameter>

@property (strong) NSString *userId;
@property (strong) NSString *userName;
@property (strong) NSString *password;
@property (strong) NSString *avatarPath;
@property (strong) NSString *phone;

@end

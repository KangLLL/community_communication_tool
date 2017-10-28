//
//  LoginResponseParameter.h
//  zhongying
//
//  Created by lik on 14-3-19.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ResponseParameter.h"
#import "CommunityParameter.h"

@interface LoginResponseParameter : NSObject<ResponseParameter>

@property (strong) NSString *userId;
@property (strong) NSString *password;
@property (strong) NSString *userName;
@property (strong) NSString *phone;
@property (assign) float money;
@property (assign) int point;
@property (strong) NSString *avatarPath;
@property (strong) NSArray *communities;

@end

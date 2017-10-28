//
//  SameHobbyMessageParameter.h
//  zhongying
//
//  Created by lik on 14-4-8.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ResponseParameter.h"

@interface AllHobbyMessageParameter : NSObject<ResponseParameter>

@property (strong) NSString *userId;
@property (strong) NSString *userName;
@property (strong) NSString *content;
@property (strong) NSString *time;

@end

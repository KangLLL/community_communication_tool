//
//  MessageParameter.h
//  zhongying
//
//  Created by lik on 14-4-8.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ResponseParameter.h"

@interface MessageParameter : NSObject<ResponseParameter>

@property (strong) NSString *fromUserId;
@property (strong) NSString *toUserId;
@property (strong) NSString *content;
@property (strong) NSString *time;

@end

//
//  AddVoteRequest.h
//  zhongying
//
//  Created by lik on 14-4-7.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RequestParameter.h"

@interface AddVoteRequestParameter : NSObject<RequestParameter>

@property (strong) NSString *userId;
@property (strong) NSString *password;
@property (strong) NSString *voteId;
@property (strong) NSArray *answer;

@end

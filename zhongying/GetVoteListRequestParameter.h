//
//  GetVoteListRequest.h
//  zhongying
//
//  Created by lik on 14-4-7.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import "PageRequestParameter.h"
#import "RequestParameter.h"

@interface GetVoteListRequestParameter : PageRequestParameter<RequestParameter>

@property (strong) NSString *communityId;

@end

//
//  GetRentRequestParameter.h
//  zhongying
//
//  Created by lik on 14-3-24.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import "PageRequestParameter.h"
#import "RequestParameter.h"

@interface GetRentRequestParameter : PageRequestParameter<RequestParameter>

@property (strong) NSString *communityId;

@end

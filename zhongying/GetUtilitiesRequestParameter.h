//
//  GetUtilitiesRequestParameter.h
//  zhongying
//
//  Created by lik on 14-3-22.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import "PageRequestParameter.h"
#import "RequestParameter.h"

@interface GetUtilitiesRequestParameter : PageRequestParameter<RequestParameter>

@property (strong) NSString *communityId;

@end

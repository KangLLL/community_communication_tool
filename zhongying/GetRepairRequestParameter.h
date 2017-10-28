//
//  GetRepairRequestParameter.h
//  zhongying
//
//  Created by lik on 14-3-23.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import "PageRequestParameter.h"
#import "RequestParameter.h"

@interface GetRepairRequestParameter : PageRequestParameter<RequestParameter>

@property (strong) NSString *communityId;

@end

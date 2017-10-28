//
//  AddHouseRequestParameter.h
//  zhongying
//
//  Created by lik on 14-3-24.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import "CommonRequestParameter.h"
#import "RequestParameter.h"

@interface BindCommunityRequestParameter : CommonRequestParameter<RequestParameter>

@property (strong) NSString *communityId;
@property (strong) NSString *buildNo;
@property (strong) NSString *floorNo;
@property (strong) NSString *roomNo;
@property (strong) NSString *ownerName;

@end

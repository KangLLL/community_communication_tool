//
//  GetCommunityRequestParameter.h
//  zhongying
//
//  Created by lik on 14-3-24.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import "CommonRequestParameter.h"
#import "RequestParameter.h"

@interface GetCommunityRequestParameter : CommonRequestParameter<RequestParameter>

@property (strong) NSString *provinceId;
@property (strong) NSString *cityId;
@property (strong) NSString *districtId;

@end

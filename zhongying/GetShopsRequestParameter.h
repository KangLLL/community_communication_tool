//
//  GetShopsRequestParameter.h
//  zhongying
//
//  Created by lk on 14-4-21.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import "PageRequestParameter.h"
#import "RequestParameter.h"

@interface GetShopsRequestParameter : PageRequestParameter<RequestParameter>

@property (strong) NSString *categoryId;
@property (strong) NSString *communityId;
@property (strong) NSString *provinceId;
@property (strong) NSString *cityId;
@property (strong) NSString *districtId;

@end

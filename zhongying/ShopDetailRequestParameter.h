//
//  GetShopDetailRequestParameter.h
//  zhongying
//
//  Created by lk on 14-4-21.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import "CommonRequestParameter.h"
#import "RequestParameter.h"

@interface ShopDetailRequestParameter : CommonRequestParameter<RequestParameter>

@property (strong) NSString *shopId;

@end

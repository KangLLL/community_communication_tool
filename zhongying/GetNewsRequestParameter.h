//
//  NewsDetailRequestParameter.h
//  zhongying
//
//  Created by lk on 14-4-22.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import "PageRequestParameter.h"
#import "RequestParameter.h"

@interface GetNewsRequestParameter : PageRequestParameter<RequestParameter>

@property (strong) NSString *categoryId;

@end

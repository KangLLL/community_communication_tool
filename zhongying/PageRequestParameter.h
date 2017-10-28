//
//  PageRequestParameter.h
//  zhongying
//
//  Created by lk on 14-5-26.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import "CommonRequestParameter.h"

@interface PageRequestParameter : CommonRequestParameter

@property (assign) int page;
@property (assign) int pageSize;

@end

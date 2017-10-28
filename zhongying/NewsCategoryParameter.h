//
//  NewsParameter.h
//  zhongying
//
//  Created by lk on 14-4-22.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ResponseParameter.h"

@interface NewsCategoryParameter : NSObject<ResponseParameter>

@property (strong) NSString *categoryId;
@property (strong) NSString *categoryName;
@property (strong) NSString *imageUrl;
@property (strong) NSString *sortOrder;
@property (strong) NSString *communityId;

@end

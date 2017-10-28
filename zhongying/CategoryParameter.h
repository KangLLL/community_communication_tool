//
//  CategoryParameter.h
//  zhongying
//
//  Created by lk on 14-4-21.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ResponseParameter.h"

@interface CategoryParameter : NSObject<ResponseParameter>

@property (strong) NSString *categoryId;
@property (strong) NSString *categoryName;
@property (assign) int shopCount;
@property (strong) NSArray *childCategories;

@end

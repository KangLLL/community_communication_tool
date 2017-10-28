//
//  NewsParameter.m
//  zhongying
//
//  Created by lk on 14-4-22.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import "NewsCategoryParameter.h"

@implementation NewsCategoryParameter

@synthesize categoryId, categoryName, imageUrl, sortOrder, communityId;

- (void)initialFromDictionaryResponse:(NSDictionary *)response
{
    self.categoryId = [response objectForKey:@"cat_id"];
    self.categoryName = [response objectForKey:@"cat_name"];
    self.imageUrl = [response objectForKey:@"article_thumb"];
    self.sortOrder = [response objectForKey:@"sort_order"];
    self.communityId = [response objectForKey:@"comm_id"];
}


@end

//
//  CategoryParameter.m
//  zhongying
//
//  Created by lk on 14-4-21.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import "CategoryParameter.h"

@implementation CategoryParameter

@synthesize categoryId, categoryName, shopCount;

- (void)initialFromDictionaryResponse:(NSDictionary *)response
{
    self.categoryId = [response objectForKey:@"cat_id"];
    self.categoryName = [response objectForKey:@"cat_name"];
    self.shopCount = [[response objectForKey:@"num"] intValue];
    
    if([response.allKeys containsObject:@"sed"]){
        NSMutableArray *temp = [NSMutableArray array];
        NSArray *children = [response objectForKey:@"sed"];
        for (NSDictionary *dict in children) {
            CategoryParameter *cate = [[CategoryParameter alloc] init];
            [cate initialFromDictionaryResponse:dict];
            [temp addObject:cate];
        }
        self.childCategories = temp;
    }
}


@end

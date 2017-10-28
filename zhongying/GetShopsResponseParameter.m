//
//  GetShopsResponseParameter.m
//  zhongying
//
//  Created by lk on 14-4-21.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import "GetShopsResponseParameter.h"
#import "ShopParameter.h"
#import "CategoryParameter.h"

@implementation GetShopsResponseParameter

@synthesize shops, categories;

- (void)initialFromDictionaryResponse:(NSDictionary *)response
{
    NSMutableArray *temp = [NSMutableArray array];
    NSArray *shop = [response objectForKey:@"shop"];
    for (NSDictionary *dict in shop) {
        ShopParameter *s = [[ShopParameter alloc] init];
        [s initialFromDictionaryResponse:dict];
        [temp addObject:s];
    }
    self.shops = temp;
    
    temp = [NSMutableArray array];
    NSArray *category = [response objectForKey:@"cate"];
    for(NSDictionary *dict in category){
        CategoryParameter *c = [[CategoryParameter alloc] init];
        [c initialFromDictionaryResponse:dict];
        [temp addObject:c];
    }
    self.categories = temp;
}

@end

//
//  GetNewsResponseParameter.m
//  zhongying
//
//  Created by lk on 14-4-22.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import "GetNewsCategoryResponseParameter.h"
#import "NewsCategoryParameter.h"

@implementation GetNewsCategoryResponseParameter

@synthesize categories;

- (void)initialFromArrayResponse:(NSArray *)response
{
    NSMutableArray *temp = [NSMutableArray array];
    for (NSDictionary *dict in response) {
        NewsCategoryParameter *param = [[NewsCategoryParameter alloc] init];
        [param initialFromDictionaryResponse:dict];
        [temp addObject:param];
    }
    self.categories = temp;
}

@end

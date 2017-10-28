//
//  GetNewsResponseParameter.m
//  zhongying
//
//  Created by lk on 14-4-22.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import "GetNewsResponseParameter.h"
#import "NewsParameter.h"

@implementation GetNewsResponseParameter

@synthesize news;

- (void)initialFromArrayResponse:(NSArray *)response
{
    NSMutableArray *temp = [NSMutableArray array];
    for (NSDictionary *dict in response) {
        NewsParameter *param = [[NewsParameter alloc] init];
        [param initialFromDictionaryResponse:dict];
        [temp addObject:param];
    }
    self.news = temp;
}

@end

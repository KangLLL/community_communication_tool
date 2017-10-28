//
//  PageRequestParameter.m
//  zhongying
//
//  Created by lk on 14-5-26.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import "PageRequestParameter.h"

@implementation PageRequestParameter

@synthesize page, pageSize;

- (NSDictionary *)getCommonDictionary
{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithDictionary:[super getCommonDictionary]];
    [parameters setObject:[NSString stringWithFormat:@"%d",self.page] forKey:@"page"];
    [parameters setObject:[NSString stringWithFormat:@"%d",self.pageSize] forKey:@"pagesize"];
    
    return parameters;
}

@end

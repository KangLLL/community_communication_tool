//
//  GetAdminMessageResponseParameter.m
//  zhongying
//
//  Created by lk on 14-5-27.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import "GetAdminMessageResponseParameter.h"
#import "AdminMessageParameter.h"

@implementation GetAdminMessageResponseParameter

@synthesize messages;

- (void)initialFromArrayResponse:(NSArray *)response
{
    NSMutableArray *temp = [NSMutableArray array];
    for (NSDictionary *dict in response) {
        AdminMessageParameter *param = [[AdminMessageParameter alloc] init];
        [param initialFromDictionaryResponse:dict];
        [temp addObject:param];
    }
    self.messages = temp;
}


@end

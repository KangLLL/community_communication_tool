//
//  GetHobbyMessagesResponseParameter.m
//  zhongying
//
//  Created by lik on 14-4-8.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import "GetAllHobbyMessageResponseParameter.h"
#import "AllHobbyMessageParameter.h"

@implementation GetAllHobbyMessageResponseParameter

@synthesize messages;

- (void)initialFromArrayResponse:(NSArray *)response
{
    NSMutableArray *temp = [NSMutableArray array];
    for (NSDictionary *dict in response) {
        AllHobbyMessageParameter *param = [[AllHobbyMessageParameter alloc] init];
        [param initialFromDictionaryResponse:dict];
        [temp addObject:param];
    }
    self.messages = temp;
}

@end

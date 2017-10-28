//
//  GetNeighbourMessageResponseParameter.m
//  zhongying
//
//  Created by lik on 14-4-10.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import "GetNeighbourMessagesResponseParameter.h"
#import "NeighbourMessageParameter.h"

@implementation GetNeighbourMessagesResponseParameter

@synthesize messages;

- (void)initialFromArrayResponse:(NSArray *)response
{
    NSMutableArray *temp = [NSMutableArray array];
    for (NSDictionary *dict in response) {
        NeighbourMessageParameter *param = [[NeighbourMessageParameter alloc] init];
        [param initialFromDictionaryResponse:dict];
        [temp addObject:param];
    }
    self.messages = temp;
}

@end

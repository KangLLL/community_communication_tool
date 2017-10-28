//
//  GetVoteListResponse.m
//  zhongying
//
//  Created by lik on 14-4-7.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import "GetVoteListResponseParameter.h"
#import "VoteParameter.h"

@implementation GetVoteListResponseParameter

- (void)initialFromArrayResponse:(NSArray *)response
{
    NSMutableArray *temp = [NSMutableArray array];
    for (NSDictionary *dict in response) {
        VoteParameter *vote = [[VoteParameter alloc] init];
        [vote initialFromDictionaryResponse:dict];
        [temp addObject:vote];
    }
    self.votes = temp;
}

@end

//
//  VoteParameter.m
//  zhongying
//
//  Created by lik on 14-4-7.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import "VoteParameter.h"
#import "VoteOptionParameter.h"

@implementation VoteParameter

@synthesize voteId, voteName, voteType, peopleCount, options;

- (void)initialFromDictionaryResponse:(NSDictionary *)response
{
    self.voteId = [response objectForKey:@"vote_id"];
    self.voteName = [response objectForKey:@"vote_name"];
    self.voteType = [[response objectForKey:@"vote_type"] intValue];
    self.peopleCount = [[response objectForKey:@"count"] intValue];
    self.isVoted = [[response objectForKey:@"is_join"] boolValue];
    NSString *selections = [response objectForKey:@"my_answer"];
    if(selections != nil){
        self.mySelection = [NSMutableArray arrayWithArray:[selections componentsSeparatedByString:@","]];
    }
    
    NSArray *array = [response objectForKey:@"option"];
    NSMutableArray *temp = [NSMutableArray array];
    for (NSDictionary *op in array) {
        VoteOptionParameter *param = [[VoteOptionParameter alloc] init];
        [param initialFromDictionaryResponse:op];
        [temp addObject:param];
    }
    self.options = temp;
}

@end

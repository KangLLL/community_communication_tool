//
//  VoteSelectionParameter.m
//  zhongying
//
//  Created by lik on 14-4-7.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import "VoteOptionParameter.h"

@implementation VoteOptionParameter

@synthesize optionId, optionName;

- (void)initialFromDictionaryResponse:(NSDictionary *)response
{
    self.optionId = [response objectForKey:@"option_id"];
    self.optionName = [response objectForKey:@"option_name"];
    
}

@end

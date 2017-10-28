//
//  GetVoteListRequest.m
//  zhongying
//
//  Created by lik on 14-4-7.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import "GetVoteListRequestParameter.h"

@implementation GetVoteListRequestParameter
@synthesize communityId;

- (NSDictionary *)convertToRequest
{
    NSMutableDictionary *result = [NSMutableDictionary dictionaryWithDictionary:[super getCommonDictionary]];
    
    [result setValue:self.communityId forKey:@"cid"];
    return result;
}

@end

//
//  GetCommunityResponseParameter.m
//  zhongying
//
//  Created by lik on 14-3-24.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import "GetCommunityResponseParameter.h"
#import "CommunityInfoParameter.h"

@implementation GetCommunityResponseParameter

@synthesize communities;

- (void)initialFromArrayResponse:(NSArray *)response
{
    NSMutableArray *temp = [NSMutableArray array];
    for (NSDictionary *dict in response) {
        CommunityInfoParameter *param = [[CommunityInfoParameter alloc] init];
        [param initialFromDictionaryResponse:dict];
        [temp addObject:param];
    }
    self.communities = temp;
}

@end

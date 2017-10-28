//
//  GetMyCommunitiesResponseParameter.m
//  zhongying
//
//  Created by lik on 14-3-21.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import "GetMyCommunitiesResponseParameter.h"
#import "MyCommunityParameter.h"

@implementation GetMyCommunitiesResponseParameter

@synthesize communities;

- (void)initialFromArrayResponse:(NSArray *)response
{
    NSMutableArray *temp = [NSMutableArray array];
    for (NSDictionary *dict in response) {
        MyCommunityParameter *param = [[MyCommunityParameter alloc] init];
        [param initialFromDictionaryResponse:dict];
        [temp addObject:param];
    }
    self.communities = temp;
}

@end

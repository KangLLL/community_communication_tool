//
//  CommunityRoomParameter.m
//  zhongying
//
//  Created by lik on 14-3-24.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import "GetCommunityRoomResponseParameter.h"
#import "BuildParameter.h"

@implementation GetCommunityRoomResponseParameter

@synthesize buildings;

- (void)initialFromArrayResponse:(NSArray *)response
{
    NSMutableArray *temp = [NSMutableArray array];
    for (NSDictionary *dict in response) {
        BuildParameter *param = [[BuildParameter alloc] init];
        [param initialFromDictionaryResponse:dict];
        [temp addObject:param];
    }
    self.buildings = temp;
}

@end

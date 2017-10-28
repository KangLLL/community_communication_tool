//
//  GetGroupsResponseParameter.m
//  zhongying
//
//  Created by apple on 14-4-13.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import "GetGroupsResponseParameter.h"
#import "GroupParameter.h"

@implementation GetGroupsResponseParameter

@synthesize groups;

- (void)initialFromArrayResponse:(NSArray *)response
{
    NSMutableArray *temp = [NSMutableArray array];
    for (NSDictionary *dict in response) {
        GroupParameter *param = [[GroupParameter alloc] init];
        [param initialFromDictionaryResponse:dict];
        [temp addObject:param];
    }
    self.groups = temp;
}


@end

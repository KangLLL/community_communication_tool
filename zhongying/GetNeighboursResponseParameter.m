//
//  GetNeighboursResponseParameter.m
//  zhongying
//
//  Created by lik on 14-4-10.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import "GetNeighboursResponseParameter.h"
#import "NeighbourParameter.h"

@implementation GetNeighboursResponseParameter

@synthesize neighbours;

- (void)initialFromArrayResponse:(NSArray *)response
{
    NSMutableArray *temp = [NSMutableArray array];
    for (NSDictionary *dict in response) {
        NeighbourParameter *param = [[NeighbourParameter alloc] init];
        [param initialFromDictionaryResponse:dict];
        [temp addObject:param];
    }
    self.neighbours = temp;
}

@end

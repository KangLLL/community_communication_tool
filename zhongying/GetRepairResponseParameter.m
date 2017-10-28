//
//  GetRepairResponseParameter.m
//  zhongying
//
//  Created by lik on 14-3-23.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import "GetRepairResponseParameter.h"
#import "RepairParameter.h"

@implementation GetRepairResponseParameter

@synthesize repairs;

- (void)initialFromArrayResponse:(NSArray *)response
{
    NSMutableArray *temp = [NSMutableArray array];
    for (NSDictionary *dict in response) {
        RepairParameter *param = [[RepairParameter alloc] init];
        [param initialFromDictionaryResponse:dict];
        [temp addObject:param];
    }
    self.repairs = temp;
}

@end

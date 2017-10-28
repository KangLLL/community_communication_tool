//
//  GetComplaintResponseParameter.m
//  zhongying
//
//  Created by lik on 14-3-23.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import "GetComplaintResponseParameter.h"
#import "ComplaintParameter.h"

@implementation GetComplaintResponseParameter

@synthesize complaints;

- (void)initialFromArrayResponse:(NSArray *)response
{
    NSMutableArray *temp = [NSMutableArray array];
    for (NSDictionary *dict in response) {
        ComplaintParameter *param = [[ComplaintParameter alloc] init];
        [param initialFromDictionaryResponse:dict];
        [temp addObject:param];
    }
    self.complaints = temp;
}

@end

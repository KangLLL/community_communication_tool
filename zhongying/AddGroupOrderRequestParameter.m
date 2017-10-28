//
//  AddGroupOrderRequestParameter.m
//  zhongying
//
//  Created by lk on 14-4-23.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import "AddGroupOrderRequestParameter.h"

@implementation AddGroupOrderRequestParameter

@synthesize groupId;

- (NSDictionary *)convertToRequest
{
    NSMutableDictionary *result = [NSMutableDictionary dictionaryWithDictionary:[super convertToRequest]];
    
    [result setObject:self.groupId forKey:@"e_id"];
    [result setObject:@"group_buy" forKey:@"e_code"];
    return result;
}


@end

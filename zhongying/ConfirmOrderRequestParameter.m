//
//  ConfirmOrderRequestParameter.m
//  zhongying
//
//  Created by lk on 14-4-23.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import "ConfirmOrderRequestParameter.h"

@implementation ConfirmOrderRequestParameter

@synthesize productId, count, attribute, limitRestrict, groupId, isGroup;

- (NSDictionary *)convertToRequest
{
    NSMutableDictionary *result = [NSMutableDictionary dictionaryWithDictionary:[super getCommonDictionary]];
    
    [result setObject:self.productId forKey:@"goods_id"];
    [result setObject:[NSString stringWithFormat:@"%d", self.count] forKey:@"num"];
    [result setObject:self.attribute forKey:@"attr"];
    [result setObject:[NSString stringWithFormat:@"%d", self.limitRestrict] forKey:@"xiangou"];
    [result setObject:self.groupId forKey:@"aid"];
    if(self.isGroup){
        [result setObject:@"0" forKey:@"tid"];
    }
    else{
        [result setObject:@"1" forKey:@"tid"];
    }
    return result;
}

@end

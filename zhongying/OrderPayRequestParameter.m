//
//  OrderPayRequestParameter.m
//  zhongying
//
//  Created by lk on 14-4-27.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import "OrderPayRequestParameter.h"

@implementation OrderPayRequestParameter

- (NSDictionary *)convertToRequest
{
    NSMutableDictionary *result = [NSMutableDictionary dictionaryWithDictionary:[super getCommonDictionary]];
    
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:self.billId,@"id",[NSString stringWithFormat:@"%d",(int)self.payType],@"paytype",[NSString stringWithFormat:@"%.2f",self.totalFee],@"price",@"3",@"tid",[payDescriptions objectForKey:[NSNumber numberWithInt:(int)self.payType]],@"payname",nil];
    [result addEntriesFromDictionary:dict];
    return result;
}

@end

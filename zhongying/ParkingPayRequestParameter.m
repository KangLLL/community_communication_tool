//
//  ParkingPayRequestParameter.m
//  zhongying
//
//  Created by lk on 14-4-19.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import "ParkingPayRequestParameter.h"

@implementation ParkingPayRequestParameter

- (NSDictionary *)convertToRequest
{
    NSMutableDictionary *result = [NSMutableDictionary dictionaryWithDictionary:[super getCommonDictionary]];
    
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:self.billId,@"id",[NSString stringWithFormat:@"%d",(int)self.payType],@"paytype",[NSString stringWithFormat:@"%.2f",self.totalFee],@"price",@"2",@"tid",[payDescriptions objectForKey:[NSNumber numberWithInt:(int)self.payType]],@"payname",[NSString stringWithFormat:@"%d",self.month],@"month",nil];
    [result addEntriesFromDictionary:dict];
    return result;
}


@end

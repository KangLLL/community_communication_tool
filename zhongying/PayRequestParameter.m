//
//  PayRequestParameter.m
//  zhongying
//
//  Created by lk on 14-4-19.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import "PayRequestParameter.h"

@implementation PayRequestParameter

@synthesize billId, totalFee, payType;

- (id)init
{
    if(self = [super init]){
        payDescriptions = [NSDictionary dictionaryWithObjectsAndKeys:@"余额支付",[NSNumber numberWithInt:(int)payYuE],@"支付宝快捷支付",[NSNumber numberWithInt:(int)payZhiFuBao],@"支付宝网页支付",[NSNumber numberWithInt:(int)payZhiFuBaoWeb],nil];
    }
    return self;
}

@end

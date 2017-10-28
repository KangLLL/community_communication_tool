//
//  ProductParameter.m
//  zhongying
//
//  Created by lk on 14-4-23.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import "ProductParameter.h"

@implementation ProductParameter

@synthesize productId, productName, productAttribute;

- (void)initialFromDictionaryResponse:(NSDictionary *)response
{
    self.productId = [response objectForKey:@"goods_id"];
    self.productName = [response objectForKey:@"goods_name"];
    self.productAttribute = [response objectForKey:@"attr"];
    self.quantity = [response objectForKey:@"goods_number"];
}


@end

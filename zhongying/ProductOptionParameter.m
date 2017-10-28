//
//  ProductOptionParameter.m
//  zhongying
//
//  Created by lk on 14-4-22.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import "ProductOptionParameter.h"

@implementation ProductOptionParameter

@synthesize optionId, productId, optionName, optionPrice;

- (void)initialFromDictionaryResponse:(NSDictionary *)response
{
    self.optionId = [response objectForKey:@"goods_attr_id"];
    self.productId = [response objectForKey:@"goods_id"];
    self.optionName = [response objectForKey:@"attr_value"];
    self.optionPrice = [[response objectForKey:@"attr_price"] floatValue];
}

@end

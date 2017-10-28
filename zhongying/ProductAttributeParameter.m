//
//  ProductAttributeParameter.m
//  zhongying
//
//  Created by lk on 14-4-22.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import "ProductAttributeParameter.h"
#import "ProductOptionParameter.h"

@implementation ProductAttributeParameter

@synthesize attributeName, attributeType, options;

- (void)initialFromDictionaryResponse:(NSDictionary *)response
{
    self.attributeName = [response objectForKey:@"attr_name"];
    self.attributeType = [[response objectForKey:@"attr_type"] intValue];
    
    NSMutableArray *temp = [NSMutableArray array];
    NSArray *array = [response objectForKey:@"attr_x"];
    for (NSDictionary *dict in array) {
        ProductOptionParameter *option = [[ProductOptionParameter alloc] init];
        [option initialFromDictionaryResponse:dict];
        [temp addObject:option];
    }
    self.options = temp;
}

@end

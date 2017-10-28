//
//  GroupDetailParameter.m
//  zhongying
//
//  Created by lk on 14-4-20.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import "GroupDetailResponseParameter.h"
#import "GroupSuggestionParameter.h"
#import "ProductAttributeParameter.h"

@implementation GroupDetailResponseParameter

@synthesize groupId, productName, originalPrice, groupPrice, discount, maxRestrict, limitRestrict, imageUrl, detailUrl, finishTime, suggestions, parameters,singleAttributeCount, multiplyAttributeCount, attributes, productId;

- (void)initialFromDictionaryResponse:(NSDictionary *)response
{
    self.groupId = [response objectForKey:@"act_id"];
    self.productId = [response objectForKey:@"goods_id"];
    self.productName = [response objectForKey:@"title"];
    self.originalPrice = [response objectForKey:@"shop_price"];
    self.groupPrice = [response objectForKey:@"price"];
    self.discount = [response objectForKey:@"discount"];
    self.maxRestrict = [[response objectForKey:@"max"] intValue];
    self.limitRestrict = [[response objectForKey:@"xiangou"] intValue];
    self.imageUrl = [response objectForKey:@"img"];
    self.detailUrl = [response objectForKey:@"info"];
    self.finishTime = [response objectForKey:@"endtime"];
    self.singleAttributeCount = [[response objectForKey:@"radio"] intValue];
    self.multiplyAttributeCount = [[response objectForKey:@"checkbox"] intValue];
    NSMutableArray *temp = [NSMutableArray array];
    if([response objectForKey:@"attr"] != [NSNull null]){
        NSArray *array = [response objectForKey:@"attr"];
        for (NSDictionary *dict in array) {
            ProductAttributeParameter *attribute = [[ProductAttributeParameter alloc] init];
            [attribute initialFromDictionaryResponse:dict];
            [temp addObject:attribute];
        }
        self.attributes = temp;
    }
    
    temp = [NSMutableArray array];
    NSArray *suggstions = [response objectForKey:@"other"];
    for (NSDictionary *dict in suggstions) {
        GroupSuggestionParameter *suggestion = [[GroupSuggestionParameter alloc] init];
        [suggestion initialFromDictionaryResponse:dict];
        [temp addObject:suggestion];
    }
    self.suggestions = temp;
}

@end

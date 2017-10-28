//
//  GroupSuggestionParameter.m
//  zhongying
//
//  Created by lk on 14-4-20.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import "GroupSuggestionParameter.h"

@implementation GroupSuggestionParameter

- (void)initialFromDictionaryResponse:(NSDictionary *)response
{
    self.groupId = [response objectForKey:@"act_id"];
    self.productName = [response objectForKey:@"title"];
    self.price = [[response objectForKey:@"price"] floatValue];
    self.imageUrl = [response objectForKey:@"img"];
}

@end

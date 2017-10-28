//
//  GroupParameter.m
//  zhongying
//
//  Created by apple on 14-4-13.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import "GroupParameter.h"

@implementation GroupParameter

@synthesize groupId, groupPrice, title, originalPrice, discount, maxRestrict, imageUrl;

- (void)initialFromDictionaryResponse:(NSDictionary *)response
{
    self.groupId = [response objectForKey:@"act_id"];
    self.title = [response objectForKey:@"title"];
    self.originalPrice = [response objectForKey:@"shop_price"];
    self.groupPrice = [response objectForKey:@"price"];
    self.discount = [response objectForKey:@"discount"];
    self.maxRestrict = [[response objectForKey:@"max"] intValue];
    self.imageUrl = [response objectForKey:@"img"];
}

@end

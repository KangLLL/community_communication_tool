//
//  HouseParameter.m
//  zhongying
//
//  Created by lik on 14-3-24.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import "HouseParameter.h"

@implementation HouseParameter

@synthesize messageId, contactName, rentType, title, price, time, description;

- (void)initialFromDictionaryResponse:(NSDictionary *)response
{
    self.messageId = [response objectForKey:@"id"];
    self.contactName = [response objectForKey:@"name"];
    self.rentType = [response objectForKey:@"rtype"];
    self.title = [response objectForKey:@"title"];
    self.price = [[response objectForKey:@"price"] floatValue];
    self.time = [response objectForKey:@"times"];
    self.description = [response objectForKey:@"house_desc"];
}
@end

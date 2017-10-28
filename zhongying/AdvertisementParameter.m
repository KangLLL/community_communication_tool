//
//  AdvertisementParameter.m
//  zhongying
//
//  Created by lk on 14-5-29.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import "AdvertisementParameter.h"


@implementation AdvertisementParameter

@synthesize imageUrl, advertisementUrl;

- (void)initialFromDictionaryResponse:(NSDictionary *)response
{
    self.imageUrl = [response objectForKey:@"pic_url"];
    self.advertisementUrl = [response objectForKey:@"link_url"];
}


@end

//
//  GetAdvertisementsResponseParameter.m
//  zhongying
//
//  Created by lk on 14-5-29.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import "GetAdvertisementsResponseParameter.h"
#import "AdvertisementParameter.h"

@implementation GetAdvertisementsResponseParameter

@synthesize advertisements;

- (void)initialFromArrayResponse:(NSArray *)response
{
    NSMutableArray *temp = [NSMutableArray array];
    for (NSDictionary *dict in response) {
        AdvertisementParameter *param = [[AdvertisementParameter alloc] init];
        [param initialFromDictionaryResponse:dict];
        [temp addObject:param];
    }
    self.advertisements = temp;
}


@end

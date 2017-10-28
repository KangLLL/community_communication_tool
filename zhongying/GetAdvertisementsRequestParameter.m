//
//  GetAdvertisementsRequestParameter.m
//  zhongying
//
//  Created by lk on 14-5-29.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import "GetAdvertisementsRequestParameter.h"

@implementation GetAdvertisementsRequestParameter

@synthesize communityId;

- (NSDictionary *)convertToRequest
{
    NSMutableDictionary *result = [NSMutableDictionary dictionaryWithDictionary:[super getCommonDictionary]];
    if(self.communityId != nil){
        [result setObject:self.communityId forKey:@"cid"];
    }
    
    return result;
}


@end

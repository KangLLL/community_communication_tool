//
//  EditAvatarRequestParameter.m
//  zhongying
//
//  Created by lk on 14-5-7.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import "EditAvatarRequestParameter.h"

@implementation EditAvatarRequestParameter

@synthesize theNewAvatar;

- (NSDictionary *)convertToRequest
{
    NSMutableDictionary *result = [NSMutableDictionary dictionaryWithDictionary:[super getCommonDictionary]];
    
    [result setObject:self.theNewAvatar forKey:@"img"];
    return result;
}

@end

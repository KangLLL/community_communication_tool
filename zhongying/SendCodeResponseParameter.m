//
//  SendCodeResponseParameter.m
//  zhongying
//
//  Created by lik on 14-3-19.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import "SendCodeResponseParameter.h"

@implementation SendCodeResponseParameter

@synthesize code;

- (void)initialFromDictionaryResponse:(NSDictionary *)response
{
    self.code = [response objectForKey:@"code"];
}

@end

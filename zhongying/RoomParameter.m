//
//  RoomParameter.m
//  zhongying
//
//  Created by lik on 14-3-25.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import "RoomParameter.h"

@implementation RoomParameter

@synthesize roomNo;

- (void)initialFromDictionaryResponse:(NSDictionary *)response
{
    self.roomNo = [response objectForKey:@"num"];
}

@end

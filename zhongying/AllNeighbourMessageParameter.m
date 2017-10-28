//
//  AllNeighbourMessageParameter.m
//  zhongying
//
//  Created by lik on 14-4-10.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import "AllNeighbourMessageParameter.h"

@implementation AllNeighbourMessageParameter

@synthesize peopleId, name, content, time;

- (void)initialFromDictionaryResponse:(NSDictionary *)response
{
    self.peopleId = [response objectForKey:@"usid"];
    if([response objectForKey:@"usname"] == [NSNull null]){
       self.name = @"";
    }
    else{
        self.name = [response objectForKey:@"usname"];
    }
    self.content = [response objectForKey:@"msg"];
    self.time = [response objectForKey:@"times"];
    self.count = [response objectForKey:@"msgnum"];
}

@end

//
//  DeleteHobbyRequestParameter.m
//  zhongying
//
//  Created by lik on 14-4-8.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import "DeleteHobbyRequestParameter.h"

@implementation DeleteHobbyRequestParameter

@synthesize hobbyId;

- (NSDictionary *)convertToRequest
{
    NSMutableDictionary *result = [NSMutableDictionary dictionaryWithDictionary:[super getCommonDictionary]];
    
    [result setValue:self.hobbyId forKey:@"hobby_id"];
    
    return result;
}

@end

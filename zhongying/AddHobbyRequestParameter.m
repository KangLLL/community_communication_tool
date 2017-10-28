//
//  AddHobbyRequestParameter.m
//  zhongying
//
//  Created by lik on 14-4-8.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import "AddHobbyRequestParameter.h"

@implementation AddHobbyRequestParameter

@synthesize hobbyId, hobbyName;

- (NSDictionary *)convertToRequest
{
    NSMutableDictionary *result = [NSMutableDictionary dictionaryWithDictionary:[super getCommonDictionary]];
    
    if(self.hobbyId != nil){
        [result setValue:self.hobbyId forKey:@"hobby_id"];
    }
    [result setValue:self.hobbyName forKey:@"hobby_name"];
    
    return result;
}

@end

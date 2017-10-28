//
//  GetMyCommunitiesRequestParameter.m
//  zhongying
//
//  Created by lik on 14-3-21.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import "GetMyCommunitiesRequestParameter.h"

@implementation GetMyCommunitiesRequestParameter

- (NSDictionary *)convertToRequest
{
    NSMutableDictionary *result = [NSMutableDictionary dictionaryWithDictionary:[super getCommonDictionary]];
    if(self.isUserCenter){
        [result setValue:@"2" forKey:@"type"];
    }
    else{
        [result setValue:@"1" forKey:@"type"];
    }
    
    return result;
}

@end

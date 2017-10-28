//
//  EditPasswordReqeustParameter.m
//  zhongying
//
//  Created by lk on 14-4-14.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import "EditPasswordReqeustParameter.h"

@implementation EditPasswordReqeustParameter

@synthesize theNewPassword;

- (NSDictionary *)convertToRequest
{
    NSMutableDictionary *result = [NSMutableDictionary dictionaryWithDictionary:[super getCommonDictionary]];
    //NSMutableDictionary *result = [NSMutableDictionary dictionary];
    //[result setValue:self.userId forKey:@"uid"];
    [result setValue:self.theOldPassword forKey:@"oldpwd"];
    [result setValue:self.theNewPassword forKey:@"newpassword"];
    
    return result;
}

@end

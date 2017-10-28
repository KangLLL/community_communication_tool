//
//  EditMyInfoRequestParameter.m
//  zhongying
//
//  Created by lik on 14-3-24.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import "EditMyInfoRequestParameter.h"

@implementation EditMyInfoRequestParameter

@synthesize realName, nickName, email, sex, identifyCardNo, birthday, msn, qq, officePhone, homePhone, mobilePhone;

- (NSDictionary *)convertToRequest
{
    NSMutableDictionary *result = [NSMutableDictionary dictionaryWithDictionary:[super getCommonDictionary]];
    NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys:self.realName,@"real_name",self.nickName, @"user_name", self.email,@"email",[NSString stringWithFormat:@"%d",(int)self.sex],@"sex",self.identifyCardNo,@"id_card",self.birthday,@"birthday",self.msn,@"msn",self.qq,@"qq",self.officePhone,@"office_phone",self.homePhone,@"home_phone",self.mobilePhone,@"mobile_phone",nil];
    [result addEntriesFromDictionary:parameters];
    return result;
}

@end

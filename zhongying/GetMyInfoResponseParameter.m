//
//  GetMyInfoResponseParameter.m
//  zhongying
//
//  Created by lik on 14-3-24.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import "GetMyInfoResponseParameter.h"

@implementation GetMyInfoResponseParameter

@synthesize realName, email, sex, identifyCardNo, birthday, msn, qq, officePhone, homePhone, mobilePhone;

- (void)initialFromDictionaryResponse:(NSDictionary *)response
{
    self.realName = [response objectForKey:@"real_name"];
    self.nickName = [response objectForKey:@"user_name"];
    self.email = [response objectForKey:@"email"];
    self.sex = [[response objectForKey:@"sex"] intValue];
    self.identifyCardNo = [response objectForKey:@"id_card"];
    self.birthday = [response objectForKey:@"birthday"];
    self.msn = [response objectForKey:@"msn"];
    self.qq = [response objectForKey:@"qq"];
    self.officePhone = [response objectForKey:@"office_phone"];
    self.homePhone = [response objectForKey:@"home_phone"];
    self.mobilePhone = [response objectForKey:@"mobile_phone"];
}

@end

//
//  GetMyInfoResponseParameter.h
//  zhongying
//
//  Created by lik on 14-3-24.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ResponseParameter.h"
#import "CommonEnum.h"

@interface GetMyInfoResponseParameter : NSObject<ResponseParameter>

@property (strong) NSString *realName;
@property (strong) NSString *nickName;
@property (strong) NSString *email;
@property (assign) SexType sex;
@property (strong) NSString *identifyCardNo;
@property (strong) NSString *birthday;
@property (strong) NSString *msn;
@property (strong) NSString *qq;
@property (strong) NSString *officePhone;
@property (strong) NSString *homePhone;
@property (strong) NSString *mobilePhone;

@end
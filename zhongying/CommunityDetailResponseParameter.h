//
//  CommunityDetailResponseParameter.h
//  zhongying
//
//  Created by lk on 14-5-25.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ResponseParameter.h"

@interface CommunityDetailResponseParameter : NSObject<ResponseParameter>

@property (strong) NSString *communityName;
@property (strong) NSString *communityPhotoUrl;
@property (strong) NSString *buildTime;
@property (strong) NSString *finishTime;
@property (strong) NSString *buildCompany;
@property (strong) NSString *propertyAddress;
@property (strong) NSString *propertyPrice;
@property (strong) NSString *propertyPhone;
@property (strong) NSString *complaintPhone;
@property (strong) NSString *description;

@end

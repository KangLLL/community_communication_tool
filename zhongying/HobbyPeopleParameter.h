//
//  HobbyPeopleParameter.h
//  zhongying
//
//  Created by lik on 14-4-8.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ResponseParameter.h"

@interface HobbyPeopleParameter : NSObject<ResponseParameter>

@property (strong) NSString *userId;
@property (strong) NSString *userName;
@property (assign) int totalPeopleNumber;
@property (strong) NSString *buildNo;
@property (strong) NSString *floorNo;
@property (strong) NSString *roomNo;
@property (strong) NSString *communityName;

@end

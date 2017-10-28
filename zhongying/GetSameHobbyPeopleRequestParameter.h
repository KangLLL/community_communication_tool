//
//  GetSameHobbyPeopleRequestParameter.h
//  zhongying
//
//  Created by lik on 14-4-8.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import "PageRequestParameter.h"
#import "RequestParameter.h"

@interface GetSameHobbyPeopleRequestParameter : PageRequestParameter<RequestParameter>

@property (strong) NSString *hobbyId;
@property (strong) NSString *communityId;
@property (strong) NSString *buildNo;
@property (strong) NSString *floorNo;
@property (strong) NSString *roomNo;

@end

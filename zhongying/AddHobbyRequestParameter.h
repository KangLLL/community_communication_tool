//
//  AddHobbyRequestParameter.h
//  zhongying
//
//  Created by lik on 14-4-8.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import "CommonRequestParameter.h"
#import "RequestParameter.h"

@interface AddHobbyRequestParameter : CommonRequestParameter<RequestParameter>

@property (strong) NSString *hobbyId;
@property (strong) NSString *hobbyName;

@end

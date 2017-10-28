//
//  HobbyMessageParameter.h
//  zhongying
//
//  Created by lik on 14-4-8.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ResponseParameter.h"

@interface GetHobbyMessageResponseParameter : NSObject<ResponseParameter>

@property (strong) NSArray *otherHobbies;
@property (strong) NSArray *messages;
@property (strong) NSString *communityName;

@end

//
//  GetGroupsResponseParameter.h
//  zhongying
//
//  Created by apple on 14-4-13.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ResponseParameter.h"

@interface GetGroupsResponseParameter : NSObject<ResponseParameter>

@property (strong) NSArray *groups;

@end

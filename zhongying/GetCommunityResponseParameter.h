//
//  GetCommunityResponseParameter.h
//  zhongying
//
//  Created by lik on 14-3-24.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ResponseParameter.h"

@interface GetCommunityResponseParameter : NSObject<ResponseParameter>

@property (strong) NSArray *communities;

@end

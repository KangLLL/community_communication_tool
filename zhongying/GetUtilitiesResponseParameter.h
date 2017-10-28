//
//  GetUtilitiesResponseParameter.h
//  zhongying
//
//  Created by lik on 14-3-22.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ResponseParameter.h"

@interface GetUtilitiesResponseParameter : NSObject<ResponseParameter>

@property (strong) NSArray *utilitiesBills;

@end

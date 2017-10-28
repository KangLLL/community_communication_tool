//
//  GetRepairResponseParameter.h
//  zhongying
//
//  Created by lik on 14-3-23.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ResponseParameter.h"

@interface GetRepairResponseParameter : NSObject<ResponseParameter>

@property (strong) NSArray *repairs;

@end

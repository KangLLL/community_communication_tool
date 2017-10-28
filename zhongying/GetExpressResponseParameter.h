//
//  GetExpressResponseParameter.h
//  zhongying
//
//  Created by lik on 14-3-22.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ResponseParameter.h"

@interface GetExpressResponseParameter : NSObject<ResponseParameter>

@property (strong) NSArray *expresses;

@end

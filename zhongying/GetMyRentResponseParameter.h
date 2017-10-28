//
//  GetMyRentResponseParameter.h
//  zhongying
//
//  Created by lik on 14-3-24.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ResponseParameter.h"

@interface GetMyRentResponseParameter : NSObject<ResponseParameter>

@property (strong) NSArray *houses;

@end

//
//  GetParkingResponseParameter.h
//  zhongying
//
//  Created by lik on 14-3-22.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ResponseParameter.h"

@interface GetParkingResponseParameter : NSObject<ResponseParameter>

@property (strong) NSArray *parkingBills;

@end

//
//  GetMyParkingResponseParameter.h
//  zhongying
//
//  Created by lik on 14-3-25.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ResponseParameter.h"

@interface GetMyParkingResponseParameter : NSObject<ResponseParameter>

@property (strong) NSArray *myParkings;

@end

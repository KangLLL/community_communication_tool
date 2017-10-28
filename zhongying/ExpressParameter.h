//
//  ExpressParameter.h
//  zhongying
//
//  Created by lik on 14-3-22.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ResponseParameter.h"

typedef enum{
    ExpressNotReceived = 0,
    ExpressReceived = 1
}ExpressStatus;

@interface ExpressParameter : NSObject<ResponseParameter>

@property (strong) NSString *goodId;
@property (strong) NSString *receivedTime;
@property (strong) NSString *buildNo;
@property (strong) NSString *floorNo;
@property (strong) NSString *roomNo;
@property (strong) NSString *name;
@property (assign) int quantity;
@property (strong) NSString *expressCrop;
@property (strong) NSString *arrivedTime;
@property (strong) NSString *getDescription;
@property (strong) NSString *communityId;
@property (assign) ExpressStatus status;

@end

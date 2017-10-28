//
//  ParkingParameter.h
//  zhongying
//
//  Created by lik on 14-3-22.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ResponseParameter.h"

@interface ParkingParameter : NSObject<ResponseParameter>

@property (strong) NSString *billId;
@property (strong) NSString *buildNo;
@property (strong) NSString *floorNo;
@property (strong) NSString *roomNo;
@property (strong) NSString *name;
@property (strong) NSString *expirationTime;
@property (assign) float price;
@property (strong) NSString *cardNo;
@property (strong) NSString *carNo;

@end

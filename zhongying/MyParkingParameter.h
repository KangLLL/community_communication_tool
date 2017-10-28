//
//  MyParkingParameter.h
//  zhongying
//
//  Created by lik on 14-3-25.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ResponseParameter.h"

@interface MyParkingParameter : NSObject<ResponseParameter>

@property (strong) NSString *billId;
@property (strong) NSString *buildNo;
@property (strong) NSString *floorNo;
@property (strong) NSString *roomNo;
@property (strong) NSString *payerName;
@property (strong) NSString *expirationTime;
@property (assign) float totalFee;
@property (strong) NSString *cardNo;
@property (strong) NSString *carNo;
@property (strong) NSString *time;

@end

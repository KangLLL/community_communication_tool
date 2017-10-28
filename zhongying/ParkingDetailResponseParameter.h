//
//  ParkingDetailResponseParameter.h
//  zhongying
//
//  Created by lik on 14-3-24.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ResponseParameter.h"

@interface ParkingDetailResponseParameter : NSObject<ResponseParameter>

@property (strong) NSString *billId;
@property (strong) NSString *buildNo;
@property (strong) NSString *floorNo;
@property (strong) NSString *roomNo;
@property (strong) NSString *ownerName;
@property (strong) NSString *expirationTime;
@property (strong) NSString *price;
@property (strong) NSString *cardNo;
@property (strong) NSString *carNo;
@property (strong) NSString *brand;
@property (assign) float remainingMoney;
@property (strong) NSArray *pays;

@end

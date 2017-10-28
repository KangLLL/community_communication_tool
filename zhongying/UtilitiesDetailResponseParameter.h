//
//  UtilitiesDetailResponseParameter.h
//  zhongying
//
//  Created by lik on 14-3-24.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ResponseParameter.h"

@interface UtilitiesDetailResponseParameter : NSObject<ResponseParameter>

@property (strong) NSString *propertyFee;
@property (strong) NSString *waterFee;
@property (strong) NSString *electricityFee;
@property (strong) NSString *gasFee;
@property (strong) NSString *shareFee;
@property (strong) NSString *payerName;
@property (strong) NSString *payTime;
@property (strong) NSString *remainingMoney;
@property (strong) NSArray *pays;

@end

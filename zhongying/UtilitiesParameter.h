//
//  UtilitiesParameter.h
//  zhongying
//
//  Created by lik on 14-3-22.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ResponseParameter.h"

typedef enum{
    UtilitiesNotPay = 0,
    UtilitiesPay = 1
}UtilitiesStatus;

@interface UtilitiesParameter : NSObject<ResponseParameter>

@property (strong) NSString *billId;
@property (strong) NSString *buildNo;
@property (strong) NSString *floorNo;
@property (strong) NSString *roomNo;
@property (strong) NSString *name;
@property (strong) NSString *time;
@property (strong) NSString *totalFee;
@property (assign) UtilitiesStatus status;


@end

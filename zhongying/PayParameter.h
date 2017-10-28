//
//  PayParameter.h
//  zhongying
//
//  Created by lk on 14-4-23.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ResponseParameter.h"

@interface PayParameter : NSObject<ResponseParameter>

@property (strong) NSString *payId;
@property (strong) NSString *payName;
@property (strong) NSString *feePrice;

@end

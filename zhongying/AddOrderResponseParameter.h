//
//  AddOrderResponseParameter.h
//  zhongying
//
//  Created by lk on 14-4-23.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ResponseParameter.h"

@interface AddOrderResponseParameter : NSObject<ResponseParameter>

@property (strong) NSString *orderId;
@property (strong) NSString *orderSn;

@end

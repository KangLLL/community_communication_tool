//
//  MoneyLogParameter.h
//  zhongying
//
//  Created by lk on 14-4-25.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ResponseParameter.h"

@interface MoneyLogParameter : NSObject<ResponseParameter>

@property (strong) NSString *time;
@property (strong) NSString *money;
@property (strong) NSString *tips;
@property (strong) NSString *remainingMoney;

@end

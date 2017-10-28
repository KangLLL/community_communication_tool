//
//  PayRequestParameter.h
//  zhongying
//
//  Created by lk on 14-4-19.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import "CommonRequestParameter.h"
#import "CommonEnum.h"

@interface PayRequestParameter : CommonRequestParameter{
    NSDictionary *payDescriptions;
}

@property (strong) NSString *billId;
@property (assign) float totalFee;
@property (assign) PayType payType;

@end

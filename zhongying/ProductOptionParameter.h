//
//  ProductOptionParameter.h
//  zhongying
//
//  Created by lk on 14-4-22.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ResponseParameter.h"

@interface ProductOptionParameter : NSObject<ResponseParameter>

@property (strong) NSString *optionId;
@property (strong) NSString *productId;
@property (strong) NSString *optionName;
@property (assign) float optionPrice;

@end

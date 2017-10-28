//
//  ProductParameter.h
//  zhongying
//
//  Created by lk on 14-4-23.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ResponseParameter.h"

@interface ProductParameter : NSObject<ResponseParameter>

@property (strong) NSString *productId;
@property (strong) NSString *productName;
@property (strong) NSString *productAttribute;
@property (strong) NSString *quantity;

@end

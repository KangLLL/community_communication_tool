//
//  ShopParameter.h
//  zhongying
//
//  Created by lk on 14-4-21.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ResponseParameter.h"

@interface ShopParameter : NSObject<ResponseParameter>

@property (strong) NSString *shopId;
@property (strong) NSString *shopName;
@property (strong) NSString *address;
@property (strong) NSString *phone;
@property (assign) float mapX;
@property (assign) float mayY;
@property (strong) NSString *imageUrl;



@end

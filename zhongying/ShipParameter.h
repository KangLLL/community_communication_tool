//
//  ShipParameter.h
//  zhongying
//
//  Created by lk on 14-4-23.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ResponseParameter.h"

@interface ShipParameter : NSObject<ResponseParameter>

@property (strong) NSString *shipId;
@property (strong) NSString *shipName;
@property (strong) NSString *shipPrice;
@property (strong) NSString *insurePrice;

@end

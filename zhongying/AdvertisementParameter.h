//
//  AdvertisementParameter.h
//  zhongying
//
//  Created by lk on 14-5-29.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ResponseParameter.h"

@interface AdvertisementParameter : NSObject<ResponseParameter>

@property (strong) NSString *imageUrl;
@property (strong) NSString *advertisementUrl;

@end

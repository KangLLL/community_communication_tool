//
//  GetAddressesResponseParameter.h
//  zhongying
//
//  Created by lk on 14-4-14.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ResponseParameter.h"

@interface GetAddressesResponseParameter : NSObject<ResponseParameter>

@property (strong) NSArray *addresses;

@end

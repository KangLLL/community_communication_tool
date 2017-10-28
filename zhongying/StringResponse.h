//
//  StringResponse.h
//  zhongying
//
//  Created by lk on 14-4-17.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ResponseParameter.h"

@interface StringResponse : NSObject<ResponseParameter>

@property (strong) NSString *response;

@end

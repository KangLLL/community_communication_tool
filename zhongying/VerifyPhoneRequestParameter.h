//
//  VerifyPhoneRequestParameter.h
//  zhongying
//
//  Created by lk on 14-5-5.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RequestParameter.h"

@interface VerifyPhoneRequestParameter : NSObject<RequestParameter>

@property (strong) NSString *phone;

@end

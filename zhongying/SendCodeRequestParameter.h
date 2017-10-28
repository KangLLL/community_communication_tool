//
//  SendCodeParameter.h
//  zhongying
//
//  Created by lik on 14-3-19.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RequestParameter.h"

@interface SendCodeRequestParameter : NSObject<RequestParameter>

@property (strong) NSString *phoneNumber;

@end

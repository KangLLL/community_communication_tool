//
//  SendCodeResponseParameter.h
//  zhongying
//
//  Created by lik on 14-3-19.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ResponseParameter.h"

@interface SendCodeResponseParameter : NSObject<ResponseParameter>

@property (strong) NSString *code;

@end

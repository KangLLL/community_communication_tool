//
//  GetAdminMessageResponseParameter.h
//  zhongying
//
//  Created by lk on 14-5-27.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ResponseParameter.h"

@interface GetAdminMessageResponseParameter : NSObject<ResponseParameter>

@property (strong) NSArray *messages;

@end

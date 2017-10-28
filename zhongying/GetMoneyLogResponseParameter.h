//
//  GetMoneyLogResponseParameter.h
//  zhongying
//
//  Created by lk on 14-4-25.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ResponseParameter.h"

@interface GetMoneyLogResponseParameter : NSObject<ResponseParameter>

@property (strong) NSArray *logs;

@end

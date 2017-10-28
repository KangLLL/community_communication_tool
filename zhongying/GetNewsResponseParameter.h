//
//  GetNewsResponseParameter.h
//  zhongying
//
//  Created by lk on 14-4-22.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ResponseParameter.h"

@interface GetNewsResponseParameter : NSObject<ResponseParameter>

@property (strong) NSArray *news;

@end

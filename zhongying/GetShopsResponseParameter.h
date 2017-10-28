//
//  GetShopsResponseParameter.h
//  zhongying
//
//  Created by lk on 14-4-21.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ResponseParameter.h"

@interface GetShopsResponseParameter : NSObject<ResponseParameter>

@property (strong) NSArray *shops;
@property (strong) NSArray *categories;

@end

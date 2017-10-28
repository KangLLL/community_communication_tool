//
//  BuildParameter.h
//  zhongying
//
//  Created by lik on 14-3-25.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ResponseParameter.h"

@interface BuildParameter : NSObject<ResponseParameter>

@property (strong) NSString *buildNo;
@property (strong) NSArray *floors;

@end

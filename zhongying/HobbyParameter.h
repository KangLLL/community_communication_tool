//
//  HobbyParameter.h
//  zhongying
//
//  Created by lik on 14-4-8.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ResponseParameter.h"

@interface HobbyParameter : NSObject<ResponseParameter>

@property (strong) NSString *hobbyId;
@property (strong) NSString *hobbyName;

@end

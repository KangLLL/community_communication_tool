//
//  NeighbourMessageParameter.h
//  zhongying
//
//  Created by lik on 14-4-10.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ResponseParameter.h"

@interface NeighbourMessageParameter : NSObject<ResponseParameter>

@property (strong) NSString *fromId;
@property (strong) NSString *toId;
@property (strong) NSString *content;
@property (strong) NSString *time;

@end

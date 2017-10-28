//
//  AllNeighbourMessageParameter.h
//  zhongying
//
//  Created by lik on 14-4-10.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ResponseParameter.h"

@interface AllNeighbourMessageParameter : NSObject<ResponseParameter>

@property (strong) NSString *peopleId;
@property (strong) NSString *name;
@property (strong) NSString *content;
@property (strong) NSString *time;
@property (strong) NSString *count;

@end

//
//  GetNeighbourMessageResponseParameter.h
//  zhongying
//
//  Created by lik on 14-4-10.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ResponseParameter.h"

@interface GetNeighbourMessagesResponseParameter : NSObject<ResponseParameter>

@property (strong) NSArray *messages;

@end

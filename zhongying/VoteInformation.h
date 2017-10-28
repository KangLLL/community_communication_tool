//
//  VoteInformation.h
//  zhongying
//
//  Created by lik on 14-4-7.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VoteParameter.h"

@interface VoteInformation : NSObject

@property (strong) VoteParameter *voteParameter;
@property (strong) NSMutableArray *selections;

@end

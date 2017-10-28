//
//  VoteParameter.h
//  zhongying
//
//  Created by lik on 14-4-7.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ResponseParameter.h"

typedef enum{
    voteMultiply,
    voteSingle,
    voteStar
}VoteType;

@interface VoteParameter : NSObject<ResponseParameter>

@property (strong) NSString *voteId;
@property (strong) NSString *voteName;
@property (assign) VoteType voteType;
@property (assign) int peopleCount;
@property (strong) NSArray *options;
@property (assign) BOOL isVoted;
@property (strong) NSMutableArray *mySelection;

@end

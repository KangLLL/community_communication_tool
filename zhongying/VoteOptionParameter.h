//
//  VoteSelectionParameter.h
//  zhongying
//
//  Created by lik on 14-4-7.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ResponseParameter.h"

@interface VoteOptionParameter : NSObject<ResponseParameter>

@property (strong) NSString *optionId;
@property (strong) NSString *optionName;



@end

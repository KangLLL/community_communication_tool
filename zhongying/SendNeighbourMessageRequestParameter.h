//
//  SendNeighbourMessageRequestParameter.h
//  zhongying
//
//  Created by lik on 14-4-10.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import "CommonRequestParameter.h"
#import "RequestParameter.h"

@interface SendNeighbourMessageRequestParameter : CommonRequestParameter<RequestParameter>

@property (strong) NSString *toPeopleId;
@property (strong) NSString *content;

@end

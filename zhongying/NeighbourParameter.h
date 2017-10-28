//
//  NeighbourParameter.h
//  zhongying
//
//  Created by lik on 14-4-10.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ResponseParameter.h"

@interface NeighbourParameter : NSObject<ResponseParameter>

@property (strong) NSString *peopleId;
@property (strong) NSString *buildNo;
@property (strong) NSString *floorNo;
@property (strong) NSString *roomNo;
@property (strong) NSString *name;
@property (strong) NSString *messageCount;

@end

//
//  CommunityInformation.h
//  zhongying
//
//  Created by lk on 14-4-26.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface CommunityInformation : NSObject

@property (strong) NSString *communityId;
@property (strong) NSString *communityName;
@property (strong) NSString *repairNumber;
@property (strong) NSString *complaintNumber;
@property (strong) NSString *neighbourNumber;
@property (strong) NSString *city;
@property (strong) NSArray *rooms;

@end

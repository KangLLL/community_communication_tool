//
//  MyCommunityParameter.h
//  zhongying
//
//  Created by lik on 14-3-21.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ResponseParameter.h"

typedef enum{
    ewmPassed = 1,
    ewmProcessing = 2,
    ewmNotPassed = 3
}ewmSatus;

@interface MyCommunityParameter : NSObject<ResponseParameter>

@property (strong) NSString *communityName;
@property (strong) NSString *communityId;
@property (strong) NSString *buildingNo;
@property (strong) NSString *floorNo;
@property (strong) NSString *roomNo;
@property (strong) NSString *ownerName;
@property (strong) NSString *communityPeopleCount;
@property (assign) ewmSatus twoDimensionCodeStatus;
@property (strong) NSString *city;
@property (strong) NSString *myComplaintCount;
@property (strong) NSString *myRepairCount;
//@property (assign) NSString *myNeighbourCount;

@end

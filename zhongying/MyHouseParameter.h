//
//  MyHouseParameter.h
//  zhongying
//
//  Created by lik on 14-3-24.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ResponseParameter.h"
#import "HouseParameter.h"

@interface MyHouseParameter : NSObject<ResponseParameter>

@property (strong) NSString *messageId;
@property (strong) NSString *userId;
@property (strong) NSString *communityName;
@property (strong) NSString *contactName;
@property (strong) NSString *contactPhone;
@property (strong) NSString *title;
@property (strong) NSString *rentType;
@property (assign) float price;
@property (strong) NSString *time;
@property (strong) NSString *size;
@property (strong) NSString *payType;
@property (assign) int totalRoom;
@property (assign) int totalLobby;
@property (assign) int totalToilet;
@property (strong) NSString *floorNo;
@property (strong) NSString *totalFloor;
@property (strong) NSString *description;

@end

//
//  HouseDetailParameter.h
//  zhongying
//
//  Created by lik on 14-3-24.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ResponseParameter.h"
#import "CommonEnum.h"

@interface HouseDetailResponseParameter : NSObject<ResponseParameter>

@property (strong) NSString *tile;
@property (strong) NSString *contactName;
@property (strong) NSString *contactPhone;
@property (strong) NSString *rentType;
@property (strong) NSString *payType;
@property (strong) NSString *price;
@property (strong) NSString *time;
@property (strong) NSString *description;
@property (strong) NSString *size;
@property (assign) int totalLobby;
@property (assign) int totalRoom;
@property (assign) int totalToilet;
@property (strong) NSString *floorNo;
@property (strong) NSString *totalFloor;
@property (strong) NSString *image1;
@property (strong) NSString *image2;
@property (strong) NSString *image3;

@end

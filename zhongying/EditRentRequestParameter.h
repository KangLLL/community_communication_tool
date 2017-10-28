//
//  EditRentRequestParameter.h
//  zhongying
//
//  Created by lik on 14-3-24.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import "CommonRequestParameter.h"
#import "RequestParameter.h"
#import "HouseParameter.h"
#import "ImageInformation.h"

@interface EditRentRequestParameter : CommonRequestParameter<RequestParameter>

@property (strong) NSString *communityId;
@property (strong) NSString *messageId;
@property (strong) NSString *communityName;
@property (strong) NSString *contactName;
@property (strong) NSString *contactPhone;
@property (strong) NSString *rentType;
@property (strong) NSString *title;
@property (assign) float price;
@property (strong) NSString *size;
@property (assign) int totalRoom;
@property (assign) int totalLobby;
@property (assign) int totalToilet;
@property (strong) NSString *floorNo;
@property (strong) NSString *totalFloor;
@property (strong) NSString *imagePath;
@property (strong) NSString *description;
@property (strong) NSString *payType;
@property (strong) NSArray *images;

@end

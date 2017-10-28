//
//  UserInformation.h
//  zhongying
//
//  Created by lik on 14-3-18.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MyCommunityParameter.h"
#import "HobbyParameter.h"
#import "GetMyCommunitiesResponseParameter.h"
#import "CommunityInformation.h"
#import "RoomInformation.h"

@interface UserInformation : NSObject

@property (strong) NSString *name;
@property (strong) NSString *userId;
@property (strong) NSString *password;
@property (strong) NSString *phone;
//@property (strong) NSString *nickName;
@property (assign) float money;
@property (assign) int point;
@property (strong) NSString *avatarPath;
@property (strong) NSDictionary *communities;
@property (strong) NSArray *hobbies;
@property (assign) int currentCommunityIndex;
@property (assign) int currentHobbyIndex;
@property (strong) UIImage *avatar;

+ (UserInformation *)instance;
- (void)clear;

- (void)initialCommunities:(GetMyCommunitiesResponseParameter *)response;

- (CommunityInformation *)currentCommunity;
- (CommunityInformation *)getCommunity:(int)index;
- (HobbyParameter *)currentHobby;
- (void)setCurrentCommunityId:(NSString *)communityId;
@end

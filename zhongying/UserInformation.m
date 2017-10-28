//
//  UserInformation.m
//  zhongying
//
//  Created by lik on 14-3-18.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import "UserInformation.h"
#import "MyCommunityParameter.h"
#import "CommonConsts.h"

static UserInformation *s_Sigleton;

@implementation UserInformation
@synthesize name, userId, money, point, avatarPath, communities, hobbies, currentCommunityIndex, currentHobbyIndex, avatar;

+ (UserInformation *)instance
{
    if(s_Sigleton == nil)
    {
        s_Sigleton = [[UserInformation alloc] init];
    }
    return s_Sigleton;
}

- (id)init
{
    if(self = [super init]){
        self.name = nil;
        self.userId = nil;
        self.password = nil;
        self.money = 0;
        self.point = 0;
        self.avatarPath = nil;
        self.communities = nil;
        self.currentCommunityIndex = -1;
        self.currentHobbyIndex = -1;
        self.avatar = nil;
    }
    return self;
}

- (void)clear
{
    self.name = nil;
    //self.nickName = nil;
    self.userId = nil;
    self.password = nil;
    self.money = 0;
    self.point = 0;
    self.avatarPath = nil;
    self.communities = nil;
    self.currentCommunityIndex = -1;
    self.currentHobbyIndex = -1;
    self.avatar = nil;
    
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:USER_ID_KEY];
    //[[NSUserDefaults standardUserDefaults] removeObjectForKey:USER_NICK_NAME_KEY];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:USER_PASSWORD_KEY];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:USER_NAME_KEY];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:AVATAR_PATH_KEY];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:USER_PHONE_KEY];
    //[[NSUserDefaults standardUserDefaults] synchronize];
}

- (CommunityInformation *)currentCommunity
{
    if(self.communities == nil && currentCommunityIndex < 0){
        return nil;
    }
    else{
        
        NSString *communityId = [[self.communities allKeys] objectAtIndex:self.currentCommunityIndex];
        CommunityInformation *result = [self.communities objectForKey:communityId];
        return result;
    }
}

- (HobbyParameter *)currentHobby
{
    if(self.hobbies == nil && currentHobbyIndex < 0){
        return nil;
    }
    else{
        HobbyParameter *result = [self.hobbies objectAtIndex:self.currentHobbyIndex];
        return result;
    }
}

- (void)initialCommunities:(GetMyCommunitiesResponseParameter *)response
{
    NSMutableDictionary *temp = [NSMutableDictionary dictionary];
    
    for (MyCommunityParameter *param in response.communities) {
        if([[temp allKeys] containsObject:param.communityId]){
            CommunityInformation *cInfo = [temp objectForKey:param.communityId];
            
            NSMutableArray *tempRooms = [NSMutableArray arrayWithArray:cInfo.rooms];
            RoomInformation *rInfo = [[RoomInformation alloc] init];
            rInfo.buildNo = param.buildingNo;
            rInfo.floorNo = param.floorNo;
            rInfo.roomNo = param.roomNo;
            rInfo.ownerName = param.ownerName;
            [tempRooms addObject:rInfo];
            
            cInfo.rooms = tempRooms;
        }
        else{
            CommunityInformation *cInfo = [[CommunityInformation alloc] init];
            
            cInfo.communityId = param.communityId;
            cInfo.communityName = param.communityName;
            cInfo.neighbourNumber = param.communityPeopleCount;
            cInfo.repairNumber = param.myRepairCount;
            cInfo.complaintNumber = param.myComplaintCount;
            cInfo.city = param.city;
            
            NSMutableArray *tempRooms = [NSMutableArray array];
            RoomInformation *rInfo = [[RoomInformation alloc] init];
            rInfo.buildNo = param.buildingNo;
            rInfo.floorNo = param.floorNo;
            rInfo.roomNo = param.roomNo;
            rInfo.ownerName = param.ownerName;
            [tempRooms addObject:rInfo];
            
            cInfo.rooms = tempRooms;
            
            [temp setObject:cInfo forKey:cInfo.communityId];
        }
    }
    communities = temp;
}

- (CommunityInformation *)getCommunity:(int)index
{
    NSString *communityId = [[[UserInformation instance].communities allKeys] objectAtIndex:index];
    return [[UserInformation instance].communities objectForKey:communityId];
}

- (void)setCurrentCommunityId:(NSString *)communityId
{
    self.currentCommunityIndex = [[communities allKeys] indexOfObject:communityId];
}

@end

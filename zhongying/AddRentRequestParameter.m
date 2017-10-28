//
//  AddRentRequestParameter.m
//  zhongying
//
//  Created by lik on 14-3-24.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import "AddRentRequestParameter.h"

@implementation AddRentRequestParameter

@synthesize communityId, communityName, contactName, contactPhone, rentType, title, price, size, totalRoom, totalLobby, totalToilet, floorNo, totalFloor,imagePath, description, payType, images;

- (id)init
{
    if(self = [super init]){
        self.images = [[NSArray alloc] init];
    }
    return self;
}

- (NSDictionary *)convertToRequest
{
    NSMutableDictionary *result = [NSMutableDictionary dictionaryWithDictionary:[super getCommonDictionary]];
    
    NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys:self.communityId,@"cid",self.communityName, @"house_area",self.contactName,@"house_owner",self.contactPhone, @"house_tel",self.rentType,@"rent_type",self.title,@"house_title",[NSString stringWithFormat:@"%f",self.price],@"rent_money",self.size,@"mj",[NSString stringWithFormat:@"%d",self.totalRoom],@"shi",[NSString stringWithFormat:@"%d",self.totalLobby],@"ting",[NSString stringWithFormat:@"%d",self.totalToilet],@"wei",self.floorNo,@"floor",self.totalFloor,@"total_floor",self.description,@"house_desc",self.payType,@"money_type",nil];
    [result addEntriesFromDictionary:parameters];
    
    if([self.images count]){
        [result setObject:self.images forKey:@"house_img[]"];
    }
    
    return result;
}

@end

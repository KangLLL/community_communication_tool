//
//  CommunityDetailResponseParameter.m
//  zhongying
//
//  Created by lk on 14-5-25.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import "CommunityDetailResponseParameter.h"

@implementation CommunityDetailResponseParameter

@synthesize communityName,communityPhotoUrl,buildTime,finishTime,buildCompany,propertyAddress,propertyPrice, propertyPhone,complaintPhone,description;

- (void)initialFromArrayResponse:(NSArray *)response
{
    [self initialFromDictionaryResponse:[response objectAtIndex:0]];
}


- (void)initialFromDictionaryResponse:(NSDictionary *)response
{
    self.communityName = [response objectForKey:@"comm_name"];
    self.communityPhotoUrl = [response objectForKey:@"comm_img"];
    self.buildTime = [response objectForKey:@"bulid_time"];
    self.finishTime = [response objectForKey:@"finish_time"];
    self.buildCompany = [response objectForKey:@"builder"];
    self.propertyAddress = [response objectForKey:@"wy_add"];
    self.propertyPrice = [response objectForKey:@"comm_money"];
    self.propertyPhone = [response objectForKey:@"link_tel"];
    self.complaintPhone = [response objectForKey:@"ask_tel"];
    self.description = [response objectForKey:@"comm_desc"];
}

@end

//
//  AddComplaintRequestParameter.m
//  zhongying
//
//  Created by lik on 14-3-24.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import "AddComplaintRequestParameter.h"

@implementation AddComplaintRequestParameter

@synthesize communityId, title, content, images, buildNo, floorNo, roomNo, telephone,userName;

- (id)init
{
    if(self = [super init]){
        self.images = [NSMutableArray array];
    }
    return self;
}

- (NSDictionary *)convertToRequest
{
    NSMutableDictionary *result = [NSMutableDictionary dictionaryWithDictionary:[super getCommonDictionary]];
    
    NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys:self.userId,@"uid",self.password,@"password",self.communityId,@"cid",@"0",@"tid",self.title,@"title",self.content,@"content",self.buildNo,@"build",self.floorNo,@"floor",self.roomNo,@"num",self.telephone,@"tel",self.userName,@"username", nil];
    
    [result addEntriesFromDictionary:parameters];
    
    if([self.images count] > 0){
        [result setObject:self.images forKey:@"img[]"];
    }
    return result;
}
@end

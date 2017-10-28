//
//  RepairDetailResponseParameter.m
//  zhongying
//
//  Created by lk on 14-4-26.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import "RepairDetailResponseParameter.h"

@implementation RepairDetailResponseParameter

@synthesize messageId, userId, communityId, userName, userEmail, messageTitle, responseType, content, time, image1Url, image2Url, image3Url, comment, buildNo, floorNo, roomNo;

- (void)initialFromDictionaryResponse:(NSDictionary *)response
{
    self.messageId = [response objectForKey:@"msg_id"];
    self.userId = [response objectForKey:@"user_id"];
    self.communityId = [response objectForKey:@"comm_id"];
    self.buildNo = [response objectForKey:@"build"];
    self.floorNo = [response objectForKey:@"floor"];
    self.roomNo = [response objectForKey:@"num"];
    self.userName = [response objectForKey:@"user_name"];
    self.userEmail = [response objectForKey:@"user_email"];
    self.messageTitle = [response objectForKey:@"msg_title"];
    self.responseType = [[response objectForKey:@"msg_status"] intValue];
    self.content = [response objectForKey:@"msg_content"];
    self.time = [response objectForKey:@"msg_time"];
    self.image1Url = [response objectForKey:@"message_img1"];
    self.image2Url = [response objectForKey:@"message_img2"];
    self.image3Url = [response objectForKey:@"message_img3"];
    self.comment = [response objectForKey:@"comment"];
}

@end

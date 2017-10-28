//
//  HobbyMessageParameter.m
//  zhongying
//
//  Created by lik on 14-4-8.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import "GetHobbyMessageResponseParameter.h"
#import "MessageParameter.h"

@implementation GetHobbyMessageResponseParameter

@synthesize otherHobbies, messages, communityName;

- (void)initialFromDictionaryResponse:(NSDictionary *)response
{
    NSArray *otherHobbiesArray = [response objectForKey:@"hobby"];
    NSMutableArray *tempOtherHobbies = [NSMutableArray array];
    for (NSDictionary *dict in otherHobbiesArray) {
        [tempOtherHobbies addObject:[dict objectForKey:@"hobby_name"]];
    }
    NSArray *messageArray = [response objectForKey:@"msg"];
    self.otherHobbies = tempOtherHobbies;
    NSMutableArray *tempMessages = [NSMutableArray array];
    for (NSDictionary *dict in messageArray) {
        MessageParameter *param = [[MessageParameter alloc] init];
        [param initialFromDictionaryResponse:dict];
        [tempMessages addObject:param];
    }
    self.messages = tempMessages;
    self.communityName = [response objectForKey:@"comm_name"];
}

@end

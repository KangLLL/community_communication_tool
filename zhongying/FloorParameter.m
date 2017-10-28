//
//  FloorParameter.m
//  zhongying
//
//  Created by lik on 14-3-25.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import "FloorParameter.h"
#import "RoomParameter.h"

@implementation FloorParameter

@synthesize floorNo, rooms;

- (void)initialFromDictionaryResponse:(NSDictionary *)response
{
    self.floorNo = [response objectForKey:@"floor"];
    NSArray *array = [response objectForKey:@"contain2"];
    NSMutableArray *temp = [NSMutableArray array];
    for (NSDictionary *dict in array) {
        RoomParameter *room = [[RoomParameter alloc] init];
        [room initialFromDictionaryResponse:dict];
        [temp addObject:room];
    }
    self.rooms = temp;
}

@end

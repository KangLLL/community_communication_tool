//
//  GetUnreadMessageResponseParameter.h
//  zhongying
//
//  Created by lk on 14-4-15.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ResponseParameter.h"

@interface GetUnreadNotificationResponseParameter : NSObject<ResponseParameter>

@property (strong) NSString *notificationCount;
@property (strong) NSString *neighbourMessageCount;
@property (strong) NSString *hobbyMesssageCount;

@end

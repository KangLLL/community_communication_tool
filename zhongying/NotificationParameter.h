//
//  NotificationParameter.h
//  zhongying
//
//  Created by lik on 14-3-24.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ResponseParameter.h"

typedef enum{
    NotRead,
    Readed
}NotificationStatus;

@interface NotificationParameter : NSObject<ResponseParameter>

@property (strong) NSString *messageId;
@property (strong) NSString *title;
@property (strong) NSString *time;
@property (assign) NotificationStatus status;
@property (strong) NSString *content;

@end

//
//  AdminMessageParameter.h
//  zhongying
//
//  Created by lk on 14-5-27.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CommonEnum.h"
#import "ResponseParameter.h"

@interface AdminMessageParameter : NSObject<ResponseParameter>

@property (strong) NSString *messageId;
@property (strong) NSString *title;
@property (strong) NSString *time;
@property (assign) MessageReadStatus messageStatus;
@property (strong) NSString *content;

@end

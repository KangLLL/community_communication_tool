//
//  ComplaintParameter.h
//  zhongying
//
//  Created by lik on 14-3-23.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ResponseParameter.h"
#import "CommonEnum.h"


@interface ComplaintParameter : NSObject<ResponseParameter>

@property (strong) NSString *messageId;
@property (strong) NSString *userId;
@property (strong) NSString *communityId;
@property (strong) NSString *userName;
@property (strong) NSString *userEmail;
@property (strong) NSString *title;
@property (assign) MessageResponseType responseType;
@property (strong) NSString *content;
@property (strong) NSString *time;
@property (strong) NSString *imagePath;

@end

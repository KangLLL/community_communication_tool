//
//  RepairDetailResponseParameter.h
//  zhongying
//
//  Created by lk on 14-4-26.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ResponseParameter.h"
#import "CommonEnum.h"

@interface RepairDetailResponseParameter : NSObject<ResponseParameter>

@property (strong) NSString *messageId;
@property (strong) NSString *userId;
@property (strong) NSString *communityId;
@property (strong) NSString *buildNo;
@property (strong) NSString *floorNo;
@property (strong) NSString *roomNo;
@property (strong) NSString *userName;
@property (strong) NSString *userEmail;
@property (strong) NSString *messageTitle;
@property (assign) MessageResponseType responseType;
@property (strong) NSString *content;
@property (strong) NSString *time;
@property (strong) NSString *image1Url;
@property (strong) NSString *image2Url;
@property (strong) NSString *image3Url;
@property (strong) NSString *comment;

@end

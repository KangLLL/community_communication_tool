//
//  HouseParameter.h
//  zhongying
//
//  Created by lik on 14-3-24.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ResponseParameter.h"


@interface HouseParameter : NSObject<ResponseParameter>

@property (strong) NSString *messageId;
@property (strong) NSString *contactName;
@property (strong) NSString *rentType;
@property (strong) NSString *title;
@property (assign) float price;
@property (strong) NSString *time;
@property (strong) NSString *description;

@end

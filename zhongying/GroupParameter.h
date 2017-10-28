//
//  GroupParameter.h
//  zhongying
//
//  Created by apple on 14-4-13.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ResponseParameter.h"

@interface GroupParameter : NSObject<ResponseParameter>

@property (strong) NSString *groupId;
@property (strong) NSString *title;
@property (strong) NSString *originalPrice;
@property (strong) NSString *groupPrice;
@property (strong) NSString *discount;
@property (assign) int maxRestrict;
@property (strong) NSString *imageUrl;

@end

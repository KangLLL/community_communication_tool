//
//  GetAdvertisementsResponseParameter.h
//  zhongying
//
//  Created by lk on 14-5-29.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ResponseParameter.h"

@interface GetAdvertisementsResponseParameter : NSObject<ResponseParameter>

@property (strong) NSArray *advertisements;

@end

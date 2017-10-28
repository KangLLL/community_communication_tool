//
//  CommonRequestParameter.h
//  zhongying
//
//  Created by lik on 14-4-8.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CommonRequestParameter : NSObject

@property (strong) NSString *userId;
@property (strong) NSString *password;

- (NSDictionary *)getCommonDictionary;

@end

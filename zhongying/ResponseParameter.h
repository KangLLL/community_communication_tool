//
//  ResponseParameter.h
//  zhongying
//
//  Created by lik on 14-3-19.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ResponseParameter <NSObject>

@optional
- (void)initialFromDictionaryResponse:(NSDictionary *)response;
- (void)initialFromArrayResponse:(NSArray *)response;
- (void)initialFromStringResponse:(NSString *)response;

@end

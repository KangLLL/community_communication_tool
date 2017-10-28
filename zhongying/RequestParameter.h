//
//  RequestParameter.h
//  zhongying
//
//  Created by lik on 14-3-19.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol RequestParameter <NSObject>

@required
- (NSDictionary *)convertToRequest;

@end

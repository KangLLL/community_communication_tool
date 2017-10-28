//
//  ServerFailInformation.h
//  zhongying
//
//  Created by lik on 14-3-19.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ServerFailInformation : NSObject

@property (assign) BOOL isUnlogin;
@property (strong) NSString *message;

@end

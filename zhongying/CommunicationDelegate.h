//
//  CommunicationDelegate.h
//  zhongying
//
//  Created by lik on 14-3-19.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ServerFailInformation.h"

@protocol CommunicationDelegate <NSObject>

- (void)ProcessCommunicationError:(NSError *)error;
- (void)ProcessServerFail:(ServerFailInformation *)failInfo;
- (void)ProcessServerResponse:(id)response;

@end

//
//  RepairDetailRequestParameter.h
//  zhongying
//
//  Created by lk on 14-4-26.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import "CommonRequestParameter.h"
#import "RequestParameter.h"

@interface RepairDetailRequestParameter : CommonRequestParameter<RequestParameter>

@property (strong) NSString *messageId;

@end

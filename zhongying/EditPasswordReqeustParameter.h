//
//  EditPasswordReqeustParameter.h
//  zhongying
//
//  Created by lk on 14-4-14.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import "CommonRequestParameter.h"
#import "RequestParameter.h"

@interface EditPasswordReqeustParameter : CommonRequestParameter<RequestParameter>

@property (strong) NSString *theOldPassword;
@property (strong) NSString *theNewPassword;

@end

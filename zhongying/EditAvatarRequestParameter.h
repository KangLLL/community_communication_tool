//
//  EditAvatarRequestParameter.h
//  zhongying
//
//  Created by lk on 14-5-7.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import "CommonRequestParameter.h"
#import "ImageInformation.h"
#import "RequestParameter.h"

@interface EditAvatarRequestParameter : CommonRequestParameter<RequestParameter>

@property (strong) ImageInformation *theNewAvatar;

@end

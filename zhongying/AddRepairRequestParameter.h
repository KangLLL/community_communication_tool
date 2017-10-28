//
//  AddRepairRequestParameter.h
//  zhongying
//
//  Created by lik on 14-3-24.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import "CommonRequestParameter.h"
#import "RequestParameter.h"
#import "ImageInformation.h"

@interface AddRepairRequestParameter : CommonRequestParameter<RequestParameter>

@property (strong) NSString *userName;
@property (strong) NSString *communityId;
@property (strong) NSString *telephone;
@property (strong) NSString *title;
@property (strong) NSString *buildNo;
@property (strong) NSString *floorNo;
@property (strong) NSString *roomNo;
@property (strong) NSString *content;
@property (strong) NSMutableArray *images;

@end

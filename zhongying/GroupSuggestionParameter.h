//
//  GroupSuggestionParameter.h
//  zhongying
//
//  Created by lk on 14-4-20.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ResponseParameter.h"

@interface GroupSuggestionParameter : NSObject<ResponseParameter>

@property (strong) NSString *groupId;
@property (strong) NSString *productName;
@property (assign) float price;
@property (strong) NSString *imageUrl;

@end

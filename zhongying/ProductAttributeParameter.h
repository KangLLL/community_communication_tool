//
//  ProductAttributeParameter.h
//  zhongying
//
//  Created by lk on 14-4-22.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CommonEnum.h"
#import "ResponseParameter.h"

@interface ProductAttributeParameter : NSObject<ResponseParameter>

@property (strong) NSString *attributeName;
@property (assign) AttributeSelectType attributeType;
@property (strong) NSArray *options;

@end

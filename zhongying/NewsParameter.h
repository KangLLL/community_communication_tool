//
//  NewsDetailResponseParameter.h
//  zhongying
//
//  Created by lk on 14-4-22.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ResponseParameter.h"

@interface NewsParameter : NSObject<ResponseParameter>

@property (strong) NSString *categoryId;
@property (strong) NSString *newsId;
@property (strong) NSString *imageUrl;
@property (strong) NSString *title;
@property (strong) NSString *content;
@property (strong) NSString *author;
@property (strong) NSString *time;
@property (strong) NSString *description;

@end

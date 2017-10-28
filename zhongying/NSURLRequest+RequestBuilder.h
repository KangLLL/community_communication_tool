//
//  NSURLRequest+RequestBuilder.h
//  myAppShopper
//
//  Created by LiK on 12-4-24.
//  Copyright (c) 2012年 Adways Co.,Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef enum{
    MethodGet,
    MethodPost
}MethodType;

@interface NSURLRequest (RequestBuilder)

+ (NSURLRequest *)requestWithMethod:(MethodType)type url:(NSString *)url parameters:(NSDictionary *)parameters;

+ (NSURLRequest *)requestAsWebViewWithMethod:(MethodType)type url:(NSString *)url parameters:(NSDictionary *)parameters;

+ (NSURLRequest *)requestAsWebViewWithUrl:(NSURL *)url;
@end

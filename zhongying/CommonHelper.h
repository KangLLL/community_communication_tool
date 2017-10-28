//
//  CommonHelper.h
//  zhongying
//
//  Created by lik on 14-4-2.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CommonHelper : NSObject

+ (UITableViewCell *)getParentCell:(UIView *)view;
+ (UIScrollView *)getParentScrollView:(UIView *)view;
+ (CGPoint)getRelatedOriginal:(UIView *)view withParent:(UIView *)parent;
+ (NSDictionary *)convertQueryString:(NSString *)query;

+ (NSDate *)getDate:(NSString *)string;
+ (NSString *)getDateString:(NSDate *)date;

+ (NSString *)getCountDownStringToDate:(NSDate *)date;

+ (UIImage *)processUploadImage:(UIImage *)image;
@end

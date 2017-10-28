//
//  CommonHelper.m
//  zhongying
//
//  Created by lik on 14-4-2.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import "CommonHelper.h"

#define UPLOAD_IMAGE_MAX_WIDTH          800
#define UPLOAD_IMAGE_MAX_HEIGHT         600

@implementation CommonHelper

+ (UITableViewCell *)getParentCell:(UIView *)view
{
    Class c = [UITableViewCell class];
    while(view != nil && ![view isKindOfClass:c]){
        view = view.superview;
    }
    if(view == nil){
        return nil;
    }
    return (UITableViewCell *)view;
}

+ (UIScrollView *)getParentScrollView:(UIView *)view
{
    while (view != nil && (![view isKindOfClass:[UIScrollView class]] || [view isKindOfClass:[UITextView class]])) {
        view = view.superview;
    }
    
    if(view == nil){
        return nil;
    }
    return (UIScrollView *)view;
}

+ (CGPoint)getRelatedOriginal:(UIView *)view withParent:(UIView *)parent
{
    float x = 0;
    float y = 0;
    
    while (view != nil && view != parent) {
        x += view.frame.origin.x;
        y += view.frame.origin.y;
        view = view.superview;
    }
    
    if(view == nil){
        return CGPointZero;
    }
    else{
        return CGPointMake(x, y);
    }
}

+ (NSDictionary *)convertQueryString:(NSString *)query;
{
    NSMutableDictionary *result = [NSMutableDictionary dictionary];
    NSArray *pairs = [query componentsSeparatedByString:@"&"];
    for (NSString *p in pairs) {
        NSArray *temp = [p componentsSeparatedByString:@"="];
        if([temp count] == 2){
            [result setObject:[temp objectAtIndex:1] forKey:[temp objectAtIndex:0]];
        }
    }
    return result;
}

+ (NSDate *)getDate:(NSString *)string
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    if([string isEqualToString:@"0000-00-00"]){
        return [NSDate date];
    }
    else{
        return [dateFormatter dateFromString:string];
    }
}

+ (NSString *)getDateString:(NSDate *)date
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    return [dateFormatter stringFromDate:date];
  
}

+ (NSString *)getCountDownStringToDate:(NSDate *)date
{
    NSTimeInterval interval = [date timeIntervalSinceNow];
    if(interval <= 0){
        return nil;
    }
    else{
        int day = (long)interval / 86400;
        int hour = ((long)interval % 86400) / 3600;
        int minute = ((long)interval % 3600) / 60;
        int second = (long)interval % 60;
        
        if(day > 0){
            return [NSString stringWithFormat:@"%d天%d小时%d分%d秒",day,hour,minute,second];
        }
        else if(hour > 0){
            return [NSString stringWithFormat:@"%d小时%d分%d秒",hour,minute,second];
        }
        else if(minute > 0){
            return [NSString stringWithFormat:@"%d分%d秒",minute,second];
        }
        else{
            return [NSString stringWithFormat:@"%d秒",second];
        }
    }
}


+ (UIImage *)processUploadImage:(UIImage *)image
{
    CGSize originalSize = image.size;
    if(originalSize.width > UPLOAD_IMAGE_MAX_WIDTH || originalSize.height > UPLOAD_IMAGE_MAX_HEIGHT){
        
        float widthScale = MIN(UPLOAD_IMAGE_MAX_WIDTH / originalSize.width , 1);
        float heightScale = MIN(UPLOAD_IMAGE_MAX_HEIGHT / originalSize.height, 1);
        
        float scaleSize = MIN(widthScale, heightScale);
        
        UIGraphicsBeginImageContext(CGSizeMake(image.size.width * scaleSize, image.size.height * scaleSize));
        [image drawInRect:CGRectMake(0, 0, image.size.width * scaleSize, image.size.height * scaleSize)];
        UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        return scaledImage;
    }
    else{
        return image;
    }
}

@end

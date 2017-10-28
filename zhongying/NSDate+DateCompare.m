//
//  NSDate+DateCompare.m
//  zhongying
//
//  Created by lik on 14-4-1.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import "NSDate+DateCompare.h"

@implementation NSDate (DateCompare)

+ (BOOL)isExpiration:(NSString *)dateString
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    NSTimeZone *timeZone = [NSTimeZone localTimeZone];
    [formatter setTimeZone:timeZone];
    [formatter setDateFormat : @"yyyy-M-d"];
    
    NSDate *dateTime = [formatter dateFromString:dateString];
    
    return [dateTime timeIntervalSinceNow] <=0;
}

@end

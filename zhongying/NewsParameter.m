//
//  NewsDetailResponseParameter.m
//  zhongying
//
//  Created by lk on 14-4-22.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import "NewsParameter.h"

@implementation NewsParameter

@synthesize categoryId, newsId, imageUrl, title, content, author, time, description;

- (void)initialFromDictionaryResponse:(NSDictionary *)response
{
    self.categoryId = [response objectForKey:@"cat_id"];
    self.newsId = [response objectForKey:@"article_id"];
    self.imageUrl = [response objectForKey:@"article_thumb"];
    self.title = [response objectForKey:@"title"];
    self.content = [response objectForKey:@"content"];
    self.author = [response objectForKey:@"author"];
    NSTimeInterval timeInterval = [[response objectForKey:@"add_time"] intValue];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timeInterval];
    self.time = [dateFormatter stringFromDate:date];
    self.description = [response objectForKey:@"description"];
}


@end

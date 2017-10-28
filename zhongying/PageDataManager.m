//
//  PageDataManager.m
//  zhongying
//
//  Created by lk on 14-5-26.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import "PageDataManager.h"

@implementation PageDataManager

- (id)initWithPageSize:(NSInteger)size
{
    if(self = [super init]){
        fullPageData = [NSMutableArray array];
        pageSize = size;
        currentPage = 0;
    }
    return self;
}

- (NSInteger)getNextLoadPage
{
    return currentPage + 1;
}

- (NSArray *)allData
{
    NSMutableArray *result = [NSMutableArray arrayWithArray:fullPageData];
    [result addObjectsFromArray:currentPageData];
    return result;
}

- (void)populateData:(NSArray *)newData
{
    int totalCount = [newData count];
    int index = 0;
    int pages = 0;
    while(totalCount >= pageSize){
        for(int i = 0; i < pageSize; i ++){
            [fullPageData addObject:[newData objectAtIndex:index + i]];
        }
        totalCount -= pageSize;
        index += pageSize;
        pages ++;
    }
    
    currentPage += pages;
    
    NSMutableArray *remainingData = [NSMutableArray array];
    for(int i = index; i < [newData count]; i ++){
        [remainingData addObject:[newData objectAtIndex:i]];
    }
    currentPageData = remainingData;
}

- (void)clear
{
    [fullPageData removeAllObjects];
    currentPageData = [NSArray array];
    currentPage = 0;
}

@end

//
//  PageDataManager.h
//  zhongying
//
//  Created by lk on 14-5-26.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PageDataManager : NSObject{
    NSInteger pageSize;
    NSInteger currentPage;
    NSMutableArray *fullPageData;
    NSArray *currentPageData;
}

- (NSInteger)getNextLoadPage;
- (NSArray *)allData;
- (void)populateData:(NSArray *)newData;
- (void)clear;
- (id)initWithPageSize:(NSInteger)size;

@end

//
//  VoteCellDelegate.h
//  zhongying
//
//  Created by lk on 14-5-29.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol VoteCellDelegate <NSObject>

- (void)voteCellSelectionChange:(NSString *)voteId andSelection:(NSArray *)selections;

@end

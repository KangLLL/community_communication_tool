//
//  DownloadCellInformation.h
//  zhongying
//
//  Created by apple on 14-4-13.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DownloadCellInformation : NSObject

@property (assign) int initialId;
@property (weak) UITableViewCell *cell;
@property (weak) UIImageView *relatedImageView;
@property (weak) UIActivityIndicatorView *activityView;

@end

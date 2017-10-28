//
//  GroupDetailSuggestCell.h
//  zhongying
//
//  Created by lk on 14-4-20.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DownloadCacher.h"

@interface GroupDetailSuggestCell : UITableViewCell{
    NSArray *arraySuggestions;
}

@property (strong) IBOutlet UIImageView *imagePhoto1;
@property (strong) IBOutlet UIImageView *imagePhoto2;
@property (strong) IBOutlet UIImageView *imagePhoto3;
@property (strong) IBOutlet UILabel *labelPrice1;
@property (strong) IBOutlet UILabel *labelPrice2;
@property (strong) IBOutlet UILabel *labelPrice3;
@property (strong) IBOutlet UILabel *labelName1;
@property (strong) IBOutlet UILabel *labelName2;
@property (strong) IBOutlet UILabel *labelName3;
@property (strong) IBOutlet UIActivityIndicatorView *activityView1;
@property (strong) IBOutlet UIActivityIndicatorView *activityView2;
@property (strong) IBOutlet UIActivityIndicatorView *activityView3;

@property (strong) IBOutlet UIView *view2;
@property (strong) IBOutlet UIView *view3;

- (void)setSuggestions:(NSArray *)suggestions withCacher:(DownloadCacher *)cacher;
- (NSString *)getSuggestionGroupId:(int)index;

@end

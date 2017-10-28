//
//  NotificationContentCell.h
//  zhongying
//
//  Created by lik on 14-4-10.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NotificationContentCell : UITableViewCell{
    UILabel *labelContent;
    float totalHeight;
}

@property (strong) IBOutlet UIImageView *imageRead;
@property (strong) IBOutlet UIImageView *imageUnread;
@property (strong) IBOutlet UILabel *labelTitle;

- (void)setContent:(NSString *)content;
- (float)getTotalHeight;
+ (float)getCellHeightAccordingToContent:(NSString *)content;
@end

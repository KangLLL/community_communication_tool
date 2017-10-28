//
//  UserCenterHeadCell.h
//  zhongying
//
//  Created by lik on 14-3-18.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserCenterHeadCell : UITableViewCell

@property (strong) IBOutlet UILabel *labelName;
@property (strong) IBOutlet UIImageView *imageAvatar;
@property (strong) IBOutlet UIActivityIndicatorView *activityView;
@property (strong) IBOutlet UIButton *buttonEditAvatar;

/*
@property (strong) IBOutlet UILabel *labelCommunityTitle;
@property (strong) IBOutlet UILabel *labelCommunityValue;
@property (strong) IBOutlet UILabel *labelMoneyTitle;
@property (strong) IBOutlet UILabel *labelMoneyValue;
@property (strong) IBOutlet UILabel *labelScoreTitle;
@property (strong) IBOutlet UILabel *labelScoreValue;
*/

@end

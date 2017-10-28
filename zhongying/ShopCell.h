//
//  ShopCell.h
//  zhongying
//
//  Created by lk on 14-4-21.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShopCell : UITableViewCell

@property (strong) IBOutlet UIImageView *imagePhoto;
@property (strong) IBOutlet UILabel *labelName;
@property (strong) IBOutlet UILabel *labelAddress;
@property (strong) IBOutlet UILabel *labelPhone;
@property (strong) IBOutlet UIActivityIndicatorView *activityView;

@end

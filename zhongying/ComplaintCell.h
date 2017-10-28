//
//  ComplaintCell.h
//  zhongying
//
//  Created by lik on 14-3-23.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ComplaintCell : UITableViewCell

@property (strong) IBOutlet UILabel *labelTime;
@property (strong) IBOutlet UILabel *labelTitle;
@property (strong) IBOutlet UILabel *labelStatus;
@property (strong) IBOutlet UIButton *buttonDetail;

@end

//
//  GroupCell.h
//  zhongying
//
//  Created by apple on 14-4-13.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GroupCell : UITableViewCell{
    UILabel *labelDiscount;
}

@property (strong) IBOutlet UIImageView *imagePhoto;
@property (strong) IBOutlet UILabel *labelName;
@property (strong) IBOutlet UILabel *labelOriginalPrice;
@property (strong) IBOutlet UILabel *labelGroupPrice;
@property (strong) IBOutlet UILabel *labelRestrict;
@property (strong) IBOutlet UIActivityIndicatorView *activity;

- (void)setOriginalPrice:(NSString *)price andGroupPrice:(NSString *)groupPrice forDiscount:(NSString *)discount;

@end

//
//  OptionCell.h
//  zhongying
//
//  Created by lik on 14-4-11.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OptionCell : UITableViewCell{
    UILabel *labelOption;
}

- (void)setOptionString:(NSString *)option withFrame:(CGRect)rect;
- (void)setOptionString:(NSString *)option;

@end

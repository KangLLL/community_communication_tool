//
//  SelectionCell.h
//  zhongying
//
//  Created by lik on 14-4-7.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import "OptionCell.h"

@interface SelectionCell : OptionCell{
    UIImageView *imageChecked;
}

- (void)setOptionString:(NSString *)option withImage:(UIImage *)image;

@end

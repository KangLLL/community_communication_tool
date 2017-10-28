//
//  SelectionViewController.h
//  zhongying
//
//  Created by lik on 14-3-21.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZhongYingBaseViewController.h"

@interface SelectionViewController : ZhongYingBaseViewController

@property (strong) IBOutlet UIView *selectionView;

- (IBAction)showSelection:(id)sender;

@end

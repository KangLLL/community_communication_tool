//
//  PayFinishViewController.h
//  zhongying
//
//  Created by lk on 14-5-7.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import "ZhongYingBaseViewController.h"

@interface PayFinishViewController : ZhongYingBaseViewController

@property (strong) IBOutlet UILabel *labelTitle;
@property (strong) IBOutlet UIButton *buttonReturn;

@property (strong) NSString *payTitle;
@property (strong) NSString *returnText;

@end

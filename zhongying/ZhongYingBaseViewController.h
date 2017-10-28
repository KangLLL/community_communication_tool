//
//  ZhongYingBaseViewController.h
//  zhongying
//
//  Created by lik on 14-3-19.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZhongYingBaseViewController : UIViewController{
    UILabel *labelMessage;
    UIView *viewMessageBG;
    NSTimer *timerMessage;
}

- (IBAction)touchBack:(id)sender;
- (IBAction)touchHome:(id)sender;

- (void)showErrorMessage:(NSString *)message;
- (void)toHomeToController:(NSString *)segueIdentifier;

@property (strong) UIViewController *backController;

@end

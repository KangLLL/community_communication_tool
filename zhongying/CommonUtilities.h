//
//  CommonUtilities.h
//  Voyages
//
//  Created by LiK on 13-2-4.
//  Copyright (c) 2013年 LI K. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CommonUtilities : NSObject{
    UIViewController *currentNetworkShowingController;
    UIActivityIndicatorView *activityView;
    UIView *maskView;
    
    UILabel *labelMessage;
    UIView *viewMessageBG;
    NSTimer *timerMessage;
}

+ (CommonUtilities *)instance;

- (void)showNetworkConnecting:(UIViewController *)controller;
- (void)hideNetworkConnecting;
- (void)showMaskView;
- (void)hideMaskView;

- (void)showGlobeMessage:(NSString *)message;
- (void)hideMessage;
@end

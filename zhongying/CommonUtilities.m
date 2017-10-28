//
//  CommonUtilities.m
//  Voyages
//
//  Created by LiK on 13-2-4.
//  Copyright (c) 2013年 LI K. All rights reserved.
//

#import "CommonUtilities.h"

#define MESSAGE_BOTTOM_DISTANCE     60

static CommonUtilities *sigleton;

@implementation CommonUtilities

+ (CommonUtilities *)instance
{
    if(sigleton == nil){
        sigleton = [[CommonUtilities alloc] init];
    }
    return sigleton;
}

- (id)init
{
    if(self = [super init]){
        activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        
        maskView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        maskView.alpha = 0.5f;
        maskView.backgroundColor = [UIColor blackColor];
        
        //selectionView = [[UITableView alloc] init];
    }
    return self;
}

- (void)showNetworkConnecting:(UIViewController *)controller
{
    controller.view.userInteractionEnabled = NO;
    currentNetworkShowingController = controller;
    [activityView removeFromSuperview];
    [maskView removeFromSuperview];
    //NSLog(@"%f,%f",controller.view.frame.size.width, [UIScreen mainScreen].bounds.size.height);
    
    activityView.frame = CGRectMake(controller.view.frame.size.width / 2 - activityView.frame.size.width / 2, [UIScreen mainScreen].bounds.size.height / 2 - activityView.frame.size.height / 2, activityView.frame.size.width, activityView.frame.size.height);
    [[UIApplication sharedApplication].keyWindow addSubview:maskView];
    //[controller.view addSubview:maskView];
    [[UIApplication sharedApplication].keyWindow addSubview:activityView];
    //[controller.view addSubview:activityView];
    //[controller.view bringSubviewToFront:activityView];
    [activityView startAnimating];
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
}

- (void)hideNetworkConnecting
{
    if(currentNetworkShowingController != nil){
        currentNetworkShowingController.view.userInteractionEnabled = YES;
    }
    [activityView stopAnimating];
    [activityView removeFromSuperview];
    [maskView removeFromSuperview];
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
}

- (void)showMaskView
{
    [maskView removeFromSuperview];
    [[UIApplication sharedApplication].keyWindow addSubview:maskView];
}

- (void)hideMaskView
{
    [maskView removeFromSuperview];
}

- (void)showGlobeMessage:(NSString *)message
{
    
    if(labelMessage == nil){
        labelMessage = [[UILabel alloc] init];
        viewMessageBG = [[UIView alloc] init];
        labelMessage.backgroundColor = [UIColor clearColor];
        labelMessage.font = [UIFont systemFontOfSize:11];
        labelMessage.textColor = [UIColor whiteColor];
        labelMessage.textAlignment = NSTextAlignmentLeft;
        viewMessageBG.backgroundColor = [UIColor blackColor];
        
        [[UIApplication sharedApplication].keyWindow addSubview:viewMessageBG];
        [[UIApplication sharedApplication].keyWindow addSubview:labelMessage];
    }
    
    viewMessageBG.hidden = NO;
    labelMessage.hidden = NO;
    
    labelMessage.alpha = 0;
    viewMessageBG.alpha = 0;
    [UIView animateWithDuration:0.5 animations:^{
        labelMessage.alpha = 1;
        viewMessageBG.alpha = 1;
    } completion:^(BOOL finished) {
        labelMessage.alpha = 1;
        viewMessageBG.alpha = 1;
    }];
    
    labelMessage.text = message;
    
    CGSize textSize = [message sizeWithFont:[UIFont systemFontOfSize:11]];
    CGRect labelFrame = CGRectMake(([UIApplication sharedApplication].keyWindow.bounds.size.width - textSize.width) / 2, [UIApplication sharedApplication].keyWindow.bounds.size.height - MESSAGE_BOTTOM_DISTANCE, textSize.width, textSize.height);
    
    CGRect viewFrame = CGRectInset(labelFrame, -10, -10);
    
    labelMessage.frame = labelFrame;
    viewMessageBG.frame = viewFrame;
    
    [[UIApplication sharedApplication].keyWindow bringSubviewToFront:viewMessageBG];
    [[UIApplication sharedApplication].keyWindow bringSubviewToFront:labelMessage];
    
    [self performSelector:@selector(hideMessage) withObject:nil afterDelay:2];
    //timerMessage = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(hideMessage) userInfo:nil repeats:NO];
}

- (void)hideMessage
{
    [timerMessage invalidate];
    labelMessage.alpha = 1;
    viewMessageBG.alpha = 1;
    [UIView animateWithDuration:0.3 animations:^{
        labelMessage.alpha = 0;
        viewMessageBG.alpha = 0;
    } completion:^(BOOL finished) {
        viewMessageBG.hidden = YES;
        labelMessage.hidden = YES;
    }];
}

@end

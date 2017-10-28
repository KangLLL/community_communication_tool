//
//  SecondViewController.m
//  zhongying
//
//  Created by lik on 14-3-18.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import "ServiceViewController.h"
#import "GroupViewController.h"
#import "UserInformation.h"
#import "CommonUtilities.h"
#import "CommonConsts.h"
#import "LoginViewController.h"

#define GROUP_SEGUE_IDENTIFIER      @"Group"
#define RENT_SEGUE_IDENTIFIER       @"Rent"
#define SHOP_SEGUE_IDENTIFIER       @"Shop"

@interface ServiceViewController ()

- (void)toSegue:(NSString *)segueIdentifier;

@end

@implementation ServiceViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    //self.hidesBottomBarWhenPushed = NO;
}

#pragma mark - Button Actions
- (IBAction)shop:(id)sender
{
    [self toSegue:SHOP_SEGUE_IDENTIFIER];
}

- (IBAction)group:(id)sender
{
    isGroup = YES;
    [self toSegue:GROUP_SEGUE_IDENTIFIER];
}

- (IBAction)reserve:(id)sender
{
    isGroup = NO;
    [self toSegue:GROUP_SEGUE_IDENTIFIER];
}

- (IBAction)rent:(id)sender
{
    [self toSegue:RENT_SEGUE_IDENTIFIER];
}

- (IBAction)complement:(id)sender
{
    [self showErrorMessage:@"功能暂未开放"];
}

- (IBAction)discount:(id)sender
{
    [self showErrorMessage:@"功能暂未开放"];
}

- (IBAction)channel:(id)sender
{
    [self showErrorMessage:@"功能暂未开放"];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    ((UIViewController *)segue.destinationViewController).hidesBottomBarWhenPushed = YES;
    if([segue.destinationViewController isKindOfClass:[GroupViewController class]]){
        GroupViewController *controller = (GroupViewController *)segue.destinationViewController;
        controller.isGroup = isGroup;
    }
    else if ([segue.destinationViewController isKindOfClass:[LoginViewController class]]){
        LoginViewController *controller = (LoginViewController *)segue.destinationViewController;
        controller.backController = self;
    }
}

- (void)toSegue:(NSString *)segueIdentifier
{
    self.hidesBottomBarWhenPushed = YES;
    if([UserInformation instance].name == nil){
        [[CommonUtilities instance] showGlobeMessage:LOG_IN_TIPS];
        [self performSegueWithIdentifier:HOME_LOGIN_SEGUE_IDENTIFIER sender:nil];
    }
    else if([[UserInformation instance] communities] == nil){
        [[CommonUtilities instance] showGlobeMessage:BIND_COMMUNITY_TIPS];
        [self performSegueWithIdentifier:HOME_COMMUNITY_SEGUE_IDENTIFIER sender:nil];
    }
    else{
        [self performSegueWithIdentifier:segueIdentifier sender:nil];
    }
    self.hidesBottomBarWhenPushed = NO;
}
@end

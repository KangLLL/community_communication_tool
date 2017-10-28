//
//  HouseKeeperViewController.m
//  zhongying
//
//  Created by lik on 14-3-18.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import "HouseKeeperViewController.h"
#import "CommonConsts.h"
#import "UserInformation.h"
#import "CommonUtilities.h"

@interface HouseKeeperViewController ()

- (void)toSegue:(NSString *)segueIdentifier;

@end

@implementation HouseKeeperViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Button Actions

- (IBAction)communityEWM:(id)sender
{
    [self showErrorMessage:@"功能暂未开放"];
}

- (IBAction)utilities:(id)sender
{
    paymentFunction = paymentUtilities;
    [self toSegue:HOME_PAYMENT_SEGUE_IDENTIFIER];
}

- (IBAction)neighbour:(id)sender
{
    [self toSegue:HOME_NEIGHBOUR_SEGUE_IDENTIFIER];
}

- (IBAction)parking:(id)sender
{
    paymentFunction = paymentParking;
    [self toSegue:HOME_PAYMENT_SEGUE_IDENTIFIER];
}

- (IBAction)express:(id)sender
{
    paymentFunction = paymentExpress;
    [self toSegue:HOME_PAYMENT_SEGUE_IDENTIFIER];
}

- (IBAction)travel:(id)sender
{
    [self showErrorMessage:@"功能暂未开放"];
}

- (IBAction)hobby:(id)sender
{
    [self toSegue:HOME_HOBBY_SEGUE_IDENTIFIER];
}

- (IBAction)news:(id)sender
{
    [self toSegue:HOME_NEWS_SEGUE_IDENTIFIER];
}

- (IBAction)complaint:(id)sender
{
    complaintFunction = complaintComplaint;
    [self toSegue:HOME_COMPLAINT_SEGUE_IDENTIFIER];
}

- (IBAction)repair:(id)sender
{
    complaintFunction = complaintRepair;
    [self toSegue:HOME_COMPLAINT_SEGUE_IDENTIFIER];
}

- (IBAction)vote:(id)sender
{
    [self toSegue:HOME_VOTE_SEGUE_IDENTIFIER];
}

#pragma mark - Private Methods
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

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    ((UIViewController *)segue.destinationViewController).hidesBottomBarWhenPushed = YES;
    
    if([segue.destinationViewController isKindOfClass:[PaymentCenterViewController class]]){
        PaymentCenterViewController *controller = (PaymentCenterViewController *)segue.destinationViewController;
        controller.currentFunction = paymentFunction;
    }
    if([segue.destinationViewController isKindOfClass:[ComplaintRepairViewController class]]){
        ComplaintRepairViewController *controller = (ComplaintRepairViewController *)segue.destinationViewController;
        controller.currentFunction = complaintFunction;
    }
}


@end

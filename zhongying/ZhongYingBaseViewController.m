//
//  ZhongYingBaseViewController.m
//  zhongying
//
//  Created by lik on 14-3-19.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import "ZhongYingBaseViewController.h"
#import "HomeViewController.h"

#define MESSAGE_BACKGROUND_MARGIN       4
#define MESSAGE_BOTTOM_DISTANCE         40

@interface ZhongYingBaseViewController ()

- (void)hideErrorMessage;

@end

@implementation ZhongYingBaseViewController

@synthesize backController;

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
    if([self respondsToSelector:@selector(edgesForExtendedLayout)]){
        self.edgesForExtendedLayout = UIRectEdgeNone;
        self.navigationController.navigationBar.translucent = NO;
        self.tabBarController.tabBar.translucent = NO;
    }
    
    //UIBarButtonItem *backItem=[[UIBarButtonItem alloc]init];
    //backItem.title=@"";
    //self.navigationItem.backBarButtonItem = backItem;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)touchBack:(id)sender
{
    if([self.navigationController.viewControllers count] > 1){
        if(self.backController == nil){
            [self.navigationController popViewControllerAnimated:YES];
        }
        else{
            [self.navigationController popToViewController:self.backController animated:YES];
        }
    }
}

- (IBAction)touchHome:(id)sender
{
    if(self.tabBarController.selectedIndex != 0){
        [self toHomeToController:nil];
    }
    else{
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
}


#pragma mark Public Methods

- (void)toHomeToController:(NSString *)segueIdentifier
{
    UINavigationController *nav = [self.tabBarController.viewControllers objectAtIndex:0];
    HomeViewController *home = (HomeViewController *)[nav.viewControllers objectAtIndex:0];
    home.performSegueIdentifier = segueIdentifier;
    
    self.tabBarController.selectedIndex = 0;
    [self.navigationController popToRootViewControllerAnimated:NO];
    
}

- (void)showErrorMessage:(NSString *)message
{
    if(timerMessage != nil){
        [timerMessage invalidate];
    }
    if(labelMessage == nil){
        labelMessage = [[UILabel alloc] init];
        labelMessage.backgroundColor = [UIColor clearColor];
        viewMessageBG = [[UIView alloc] init];
        
        labelMessage.font = [UIFont systemFontOfSize:11];
        labelMessage.textColor = [UIColor whiteColor];
        labelMessage.textAlignment = NSTextAlignmentLeft;
        viewMessageBG.backgroundColor = [UIColor blackColor];
        
        [self.view addSubview:viewMessageBG];
        [self.view addSubview:labelMessage];
    }
    
    viewMessageBG.hidden = NO;
    labelMessage.hidden = NO;
    
    labelMessage.alpha = 0;
    viewMessageBG.alpha = 0;
    [UIView animateWithDuration:0.3 animations:^{
        labelMessage.alpha = 1;
        viewMessageBG.alpha = 1;
    } completion:^(BOOL finished) {
        labelMessage.alpha = 1;
        viewMessageBG.alpha = 1;
    }];
    
    labelMessage.text = message;
    
    CGSize textSize = [message sizeWithFont:[UIFont systemFontOfSize:11]];
    CGRect labelFrame = CGRectMake((self.view.bounds.size.width - textSize.width) / 2, self.view.bounds.size.height - MESSAGE_BOTTOM_DISTANCE, textSize.width, textSize.height);
    
    CGRect viewFrame = CGRectInset(labelFrame, -MESSAGE_BACKGROUND_MARGIN, -MESSAGE_BACKGROUND_MARGIN);
    
    labelMessage.frame = labelFrame;
    viewMessageBG.frame = viewFrame;
    
    [self.view bringSubviewToFront:viewMessageBG];
    [self.view bringSubviewToFront:labelMessage];
    
    [self performSelector:@selector(hideErrorMessage) withObject:nil afterDelay:2];
    
    //timerMessage = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(hideErrorMessage) userInfo:nil repeats:NO];
}

#pragma mark - Private Methods
- (void)hideErrorMessage
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

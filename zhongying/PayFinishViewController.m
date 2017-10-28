//
//  PayFinishViewController.m
//  zhongying
//
//  Created by lk on 14-5-7.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import "PayFinishViewController.h"

@interface PayFinishViewController ()

@end

@implementation PayFinishViewController

@synthesize labelTitle, buttonReturn, payTitle, returnText;

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
    
    self.labelTitle.text = self.payTitle;
    [self.buttonReturn setTitle:self.returnText forState:UIControlStateNormal];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

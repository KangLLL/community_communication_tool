//
//  SelectionViewController.m
//  zhongying
//
//  Created by lik on 14-3-21.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import "SelectionViewController.h"

@interface SelectionViewController ()

@end

@implementation SelectionViewController

@synthesize selectionView;

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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)showSelection:(id)sender
{
    //float height = [UIApplication sharedApplication].statusBarFrame.size.height;
    NSLog(@"%f,%f",self.view.frame.origin.y, self.view.frame.size.height);
    CGRect frame = CGRectMake(20, self.view.frame.origin.y + 40, self.selectionView.frame.size.width, self.selectionView.frame.size.height);
    [UIView beginAnimations:@"Curl"context:nil];
    [UIView setAnimationDuration:0.30];
    [UIView setAnimationDelegate:self];
    [self.selectionView setFrame:frame];
    [UIView commitAnimations];

}

@end

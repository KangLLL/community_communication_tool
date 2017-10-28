//
//  ZhiFuBaoWebViewController.m
//  zhongying
//
//  Created by lk on 14-4-17.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import "ZhiFuBaoWebViewController.h"
#import "CommonHelper.h"

@interface ZhiFuBaoWebViewController ()

@end

@implementation ZhiFuBaoWebViewController

@synthesize webView, url, isPaySuccess;

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

- (void)viewDidAppear:(BOOL)animated
{
    self.url = [self.url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    //[self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.163.com"]]];
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.url]]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Web View Delegate

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSString *param = request.URL.query;
    NSDictionary *values = [CommonHelper convertQueryString:param];
    
    if([[values allKeys] containsObject:@"result"] && [[values allKeys] containsObject:@"trade_no"]){
        if([[values objectForKey:@"result"] isEqualToString:@"success"]){
            self.isPaySuccess = true;
            [self.navigationController popViewControllerAnimated:YES];
            return false;
        }
        else if([[values objectForKey:@"result"] isEqualToString:@"fail"]){
            self.isPaySuccess = false;
            [self.navigationController popViewControllerAnimated:YES];
            return false;
        }
    }
    return true;
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

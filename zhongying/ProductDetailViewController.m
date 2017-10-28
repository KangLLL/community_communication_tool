//
//  ProductDetailViewController.m
//  zhongying
//
//  Created by lk on 14-4-20.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import "ProductDetailViewController.h"
#import "NSURLRequest+RequestBuilder.h"
#import "CommonUtilities.h"

@interface ProductDetailViewController ()

- (void)loadWebContent;

@end

@implementation ProductDetailViewController

@synthesize buttonParameter, buttonWeb, webView, viewParameter, productId, productDetailUrl;

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
    self.webView.hidden = NO;
    self.viewParameter.hidden = YES;
    [self.buttonWeb setSelected:YES];
    [self.buttonParameter setSelected:NO];
    currentType = productWeb;
    // Do any additional setup after loading the view.
}

- (void)viewDidAppear:(BOOL)animated
{
    [self loadWebContent];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)displayWeb:(id)sender
{
    if(currentType != productWeb){
        currentType = productWeb;
        //self.webView.hidden = NO;
        //self.viewParameter.hidden = YES;
        [self.buttonWeb setSelected:YES];
        [self.buttonParameter setSelected:NO];
        [self loadWebContent];
    }
}

- (IBAction)displayParameter:(id)sender
{
    if(currentType != productParameter){
        currentType = productParameter;
        //self.webView.hidden = YES;
        //self.viewParameter.hidden = NO;
        [self.buttonWeb setSelected:NO];
        [self.buttonParameter setSelected:YES];
        [self loadWebContent];
    }
}

#pragma mark - Private Methods

- (void)loadWebContent
{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    [parameters setObject:self.productId forKey:@"id"];
    if(currentType == productWeb){
        [parameters setObject:@"1" forKey:@"type"];
    }
    else{
        [parameters setObject:@"2" forKey:@"type"];
    }
    
    NSURLRequest *request = [NSURLRequest requestWithMethod:MethodGet url:self.productDetailUrl parameters:parameters];
    
    [self.webView loadRequest:request];
    [[CommonUtilities instance] showNetworkConnecting:self];
}

#pragma mark - Web Delegate

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [[CommonUtilities instance] hideNetworkConnecting];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [[CommonUtilities instance] hideNetworkConnecting];
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

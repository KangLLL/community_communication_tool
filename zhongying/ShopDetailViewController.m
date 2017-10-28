//
//  ShopDetailViewController.m
//  zhongying
//
//  Created by lk on 14-4-21.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import "ShopDetailViewController.h"
#import "CommonUtilities.h"
#import "UserInformation.h"
#import "ShopDetailRequestParameter.h"
#import "NSURLRequest+RequestBuilder.h"
#import "ShopMapViewController.h"

#define SHOP_MAP_SEGUE_IDENTIFIER       @"Map"

@interface ShopDetailViewController ()

- (void)sendGetShopDetailResponse;

@end

@implementation ShopDetailViewController

@synthesize labelAddress, labelBusinessHour, labelCategory, labelName, labelPhone, labelTitle, shop, imagePhoto, activityView, webDetail;

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
    
    self.labelTitle.text = shop.shopName;
    self.labelName.text = shop.shopName;
    
    photoDownloader = [[ImageDownloader alloc] init];
    // Do any additional setup after loading the view.
}

- (void)viewDidAppear:(BOOL)animated
{
    if(currentResponse == nil){
        [self sendGetShopDetailResponse];
        [self.activityView startAnimating];
        [photoDownloader downloadImage:shop.imageUrl withDelegate:self];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Private Methods

- (void)sendGetShopDetailResponse
{
    ShopDetailRequestParameter *request = [[ShopDetailRequestParameter alloc] init];
    request.userId = [UserInformation instance].userId;
    request.password = [UserInformation instance].password;
    request.shopId = self.shop.shopId;
    [[CommunicationManager instance] getShopDetail:request withDelegate:self];
    [[CommonUtilities instance] showNetworkConnecting:self];
}

#pragma mark - Button Actions

- (IBAction)dailPhone:(id)sender
{
    NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"telprompt://%@",self.labelPhone.text];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
}

- (IBAction)findInMap:(id)sender
{
    [self performSegueWithIdentifier:SHOP_MAP_SEGUE_IDENTIFIER sender:nil];
}

#pragma mark - Communication Delegate

- (void)ProcessServerResponse:(id)response
{
    currentResponse = response;
    self.labelCategory.text = [NSString stringWithFormat:@"%@-%@",currentResponse.primaryCategory, currentResponse.subCategory];
    self.labelBusinessHour.text = currentResponse.businessHour;
    self.labelPhone.text = currentResponse.phone;
    self.labelAddress.text = currentResponse.address;
    
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:self.shop.shopId,@"id",@"3",@"type",nil];
    NSURLRequest *request = [NSURLRequest requestAsWebViewWithMethod:MethodGet url:currentResponse.detailUrl parameters:params];
    [self.webDetail loadRequest:request];
    [[CommonUtilities instance] hideNetworkConnecting];
}

- (void)ProcessServerFail:(ServerFailInformation *)failInfo
{
    [[CommonUtilities instance] hideNetworkConnecting];
    NSLog(@"%@",failInfo.message);
    [self showErrorMessage:failInfo.message];
}

- (void)ProcessCommunicationError:(NSError *)error
{
    [[CommonUtilities instance] hideNetworkConnecting];
    NSLog(@"%@",error.localizedDescription);
    [self showErrorMessage:error.localizedDescription];
}

#pragma mark - Image Downloader Delegate
- (void)imageDownloaderDownload:(ImageDownloader *)downloader downloadFinished:(NSData *)result
{
    UIImage *photo = [[UIImage alloc] initWithData:result];
    self.activityView.hidden = YES;
    self.imagePhoto.image = photo;
}

- (void)imageDownloaderDownload:(ImageDownloader *)downloader encounterError:(NSError *)error
{
    self.activityView.hidden = YES;
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    ShopMapViewController *controller = (ShopMapViewController *)segue.destinationViewController;
    controller.shopName = self.shop.shopName;
    controller.latitude = [currentResponse.mapY floatValue];//[currentResponse.mapX floatValue];
    controller.longitude = [currentResponse.mapX floatValue];//[currentResponse.mapY floatValue];
}


@end

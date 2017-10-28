//
//  AddOrderViewController.m
//  zhongying
//
//  Created by lk on 14-4-24.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import "AddOrderViewController.h"
#import "OrderDetailViewController.h"
#import "AliPayHelper.h"
#import "UserInformation.h"
#import "CommonUtilities.h"
#import "OrderPayRequestParameter.h"
#import "StringResponse.h"
#import "GroupViewController.h"
#import "PayFinishViewController.h"

#define WEB_PAY_SEGUE_IDENTIFIER        @"Web"
#define DETAIL_SEGUE_IDENTIFIER         @"Detail"
#define PAY_FINISH_SEGUE_IDENTIFIER     @"Finish"

@interface AddOrderViewController ()

- (void)payFinish;
//- (void)popView;

@end

@implementation AddOrderViewController

@synthesize labelOrderPrice, labelPayType, labelSn, currentResponse, orderPrice, payName;

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
    self.labelOrderPrice.text = self.orderPrice;
    self.labelPayType.text = self.payName;
    self.labelSn.text = currentResponse.orderSn;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated
{
    if(payWeb != nil){
        if(payWeb.isPaySuccess){
            [self showErrorMessage:@"支付成功"];
            [self payFinish];
        }
        else{
            [self showErrorMessage:@"支付失败"];
        }
    }
    payWeb = nil;
}

#pragma mark - Private Methods

- (void)payFinish
{
    [self performSegueWithIdentifier:PAY_FINISH_SEGUE_IDENTIFIER sender:nil];
    //[[CommonUtilities instance] showMaskView];
    //[self performSelector:@selector(popView) withObject:nil afterDelay:1];
}

/*
- (void)popView
{
    [[CommonUtilities instance] hideMaskView];
    [self.navigationController popToViewController:self.backController animated:YES];
}
*/

#pragma mark - Button Actions

- (IBAction)checkOrder:(id)sender
{
    [self performSegueWithIdentifier:DETAIL_SEGUE_IDENTIFIER sender:nil];
}

- (IBAction)payOrder:(id)sender
{
    OrderPayRequestParameter *request = [[OrderPayRequestParameter alloc] init];
    request.userId = [UserInformation instance].userId;
    request.password = [UserInformation instance].password;
    request.billId = self.currentResponse.orderId;
    request.payType = self.payType;
    request.totalFee = [self.orderPrice floatValue];
    [[CommunicationManager instance] payOrder:request withDelegate:self];
    [[CommonUtilities instance] showNetworkConnecting:self];

}

#pragma mark - Communication Delegate
- (void)ProcessServerResponse:(id)response
{
    StringResponse *sr = (StringResponse *)response;
    if(self.payType == payZhiFuBaoWeb){
        payUrl = sr.response;
        [self performSegueWithIdentifier:WEB_PAY_SEGUE_IDENTIFIER sender:nil];
        self.hidesBottomBarWhenPushed = YES;
    }
    else if(self.payType == payZhiFuBao){
        [[AliPayHelper instance] payProduct:self.productName withTradeNo:currentResponse.orderSn andPrice:self.orderPrice];
        [[AliPayHelper instance] setResultReceiver:@selector(payFinish)];
    }
    else{
        [self showErrorMessage:@"支付成功"];
        [self payFinish];
    }
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

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.destinationViewController isKindOfClass:[OrderDetailViewController class]]){
        OrderDetailViewController *controller = (OrderDetailViewController *)segue.destinationViewController;
        controller.orderId = currentResponse.orderId;
        controller.finishController = self.backController;
    }
    else if([segue.destinationViewController isKindOfClass:[ZhiFuBaoWebViewController class]]){
        ZhiFuBaoWebViewController *controller = (ZhiFuBaoWebViewController *)segue.destinationViewController;
        payWeb = controller;
        controller.url = payUrl;
    }
    else if([segue.destinationViewController isKindOfClass:[PayFinishViewController class]]){
        PayFinishViewController *controller = (PayFinishViewController *)segue.destinationViewController;
        controller.backController = self.backController;
        controller.payTitle = self.payName;
        GroupViewController *groupController = (GroupViewController *)self.backController;
        NSString *returnText = groupController.isGroup ? @"返回团购列表" : @"返回预定列表";
        controller.returnText = returnText;
    }
    
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

@end

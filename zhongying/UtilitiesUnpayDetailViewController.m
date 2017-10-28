//
//  UtilitiesUnpayDetailViewController.m
//  zhongying
//
//  Created by lik on 14-4-1.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import "UtilitiesUnpayDetailViewController.h"
#import "UserInformation.h"
#import "CommunicationManager.h"
#import "GetUtilitiesDetailRequestParameter.h"
#import "UtilitiesDetailResponseParameter.h"
#import "CommonUtilities.h"
#import "CommonConsts.h"
#import "UtilitiesPayRequestParameter.h"
#import "AliPayHelper.h"
#import "OptionCell.h"
#import "PayParameter.h"
#import "PayFinishViewController.h"

#define WEB_PAY_SEGUE_IDENTIFIER            @"Web"
#define PAY_FINISH_SEGUE_IDENTIFIER         @"Finish"
#define PAY_RETURN_BUTTON_TEXT              @"返回缴费中心"

@interface UtilitiesUnpayDetailViewController ()

- (void)constructSelectionTable;
- (void)showSelectionTable;
- (void)payFinish;
//- (void)popView;

@end

@implementation UtilitiesUnpayDetailViewController

@synthesize labelCommunityName, labelElectricityFee, labelGasFee, labelOwnerName, labelPropertyFee, labelRemainingMoney, labelRoomNo, labelShareFee, labelTotalFee, labelValidTime, labelWaterFee, viewMask, labelPayName, utilities, centerController;

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
    currentSelectPayIndex = -1;
    // Do any additional setup after loading the view.
}

- (void)viewDidAppear:(BOOL)animated
{
    if(webPayController == nil){
        GetUtilitiesDetailRequestParameter *request = [[GetUtilitiesDetailRequestParameter alloc] init];
        request.billId = self.utilities.billId;
        request.userId = [UserInformation instance].userId;
        request.password = [UserInformation instance].password;
        
        [[CommunicationManager instance] getUtilitiesDetail:request withDelegate:self];
        [[CommonUtilities instance] showNetworkConnecting:self];
    }
    else{
        if(webPayController.isPaySuccess){
            [self showErrorMessage:@"支付成功"];
            [self payFinish];
        }
        else{
            [self showErrorMessage:@"支付失败"];
        }
        webPayController = nil;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Button Actions
- (IBAction)selectPay:(id)sender
{
    [self showSelectionTable];
}

- (IBAction)touchPay:(id)sender
{
    if(currentSelectPayIndex < 0){
        [self showErrorMessage:@"请选择一种支付方式"];
    }
    else{
        UtilitiesPayRequestParameter *request = [[UtilitiesPayRequestParameter alloc] init];
        request.userId = [UserInformation instance].userId;
        request.password = [UserInformation instance].password;
        request.billId = self.utilities.billId;
        PayParameter *payParam = [currentResponse.pays objectAtIndex:currentSelectPayIndex];
        PayType type = [payParam.payId intValue];
        request.payType = type;
        request.totalFee = [self.utilities.totalFee floatValue];
        [[CommunicationManager instance] payUtilities:request withDelegate:self];
        [[CommonUtilities instance] showNetworkConnecting:self];
    }
}

#pragma mark - Communication Delegate
- (void)ProcessServerResponse:(id)response
{
    [[CommonUtilities instance] hideNetworkConnecting];
    if([response isKindOfClass:[StringResponse class]]){
        StringResponse *sr = (StringResponse *)response;
        PayParameter *payParam = [currentResponse.pays objectAtIndex:currentSelectPayIndex];
        PayType type = [payParam.payId intValue];
        if(type == payZhiFuBaoWeb){
            payUrl = response;
            [self performSegueWithIdentifier:WEB_PAY_SEGUE_IDENTIFIER sender:nil];
            self.hidesBottomBarWhenPushed = YES;
        }
        else if(type == payZhiFuBao){
            [[AliPayHelper instance] payProduct:[NSString stringWithFormat:@"%@%@",self.utilities.time,@"水电费"] withTradeNo:sr.response andPrice:self.utilities.totalFee];
            [[AliPayHelper instance] setResultReceiver:@selector(payFinish)];
        }
        else{
            [self showErrorMessage:@"支付成功"];
            [self payFinish];
        }
    }
    else{
        currentResponse = response;
        self.labelCommunityName.text = [[UserInformation instance] currentCommunity].communityName;
        self.labelElectricityFee.text = currentResponse.electricityFee;
        self.labelGasFee.text = currentResponse.gasFee;
        self.labelWaterFee.text = currentResponse.waterFee;
        self.labelOwnerName.text = self.utilities.name;
        self.labelPropertyFee.text = currentResponse.propertyFee;
        self.labelShareFee.text = currentResponse.shareFee;
        self.labelTotalFee.text = self.utilities.totalFee;
        self.labelValidTime.text = self.utilities.time;
        self.labelRoomNo.text = [NSString stringWithFormat:ROOM_NO_FORMAT,self.utilities.buildNo,self.utilities.floorNo,self.utilities.roomNo];
        //self.labelRemainingMoney.text = [NSString stringWithFormat:YU_E_FORMAT, param.remainingMoney];
    }
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
    [self.navigationController popViewControllerAnimated:YES];
}
*/

- (void)constructSelectionTable
{
    tableOptions = [[UITableView alloc] initWithFrame:CGRectMake(10, 0, 300, 0)];
    [tableOptions registerClass:[OptionCell class] forCellReuseIdentifier:OPTION_CELL_REUSE_IDENTIFIER];
    tableOptions.dataSource = self;
    tableOptions.delegate = self;
    tableOptions.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:tableOptions];
}

- (void)showSelectionTable
{
    if(tableOptions == nil){
        [self constructSelectionTable];
    }
    self.viewMask.hidden = NO;
    tableOptions.hidden = NO;
    
    [tableOptions reloadData];
    float totalHeight = tableOptions.contentSize.height;
    float maxHeight = self.view.bounds.size.height - 2 * MIN_SELECTION_MARGIN;
    
    CGRect newFrame = tableOptions.frame;
    newFrame.size.height = MIN(totalHeight, maxHeight);
    tableOptions.frame = newFrame;
    tableOptions.center = self.view.center;
}

#pragma mark - Table Delegate
- (int)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(currentResponse == nil){
        return 0;
    }
    return currentResponse.pays.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    OptionCell *cell = [tableView dequeueReusableCellWithIdentifier:OPTION_CELL_REUSE_IDENTIFIER forIndexPath:indexPath];
    PayParameter *param = [currentResponse.pays objectAtIndex:indexPath.row];
        [cell setOptionString:param.payName];
    
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableOptions.bounds.size.width, 44)];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, view.frame.size.width, 44)];
    
    label.text = @"    请选择支付方式";
    view.backgroundColor = [UIColor blackColor];
    label.textColor = [UIColor whiteColor];
    label.backgroundColor = [UIColor clearColor];
    [view addSubview:label];
    
    return view;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    currentSelectPayIndex = indexPath.row;
    PayParameter *pay = [currentResponse.pays objectAtIndex:currentSelectPayIndex];
    self.labelPayName.text = pay.payName;

    tableOptions.hidden = YES;
    self.viewMask.hidden = YES;
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.destinationViewController isKindOfClass:[ZhiFuBaoWebViewController class]]){
        webPayController = (ZhiFuBaoWebViewController *)segue.destinationViewController;
        webPayController.url = payUrl.response;
    }
    else if([segue.destinationViewController isKindOfClass:[PayFinishViewController class]]){
        PayFinishViewController *controller = (PayFinishViewController *)segue.destinationViewController;
        controller.backController = self.centerController;
        PayParameter *pay = [currentResponse.pays objectAtIndex:currentSelectPayIndex];
        controller.payTitle = pay.payName;
        controller.returnText = PAY_RETURN_BUTTON_TEXT;
    }
}

@end

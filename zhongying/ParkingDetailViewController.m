//
//  ParkingDetailViewController.m
//  zhongying
//
//  Created by lik on 14-4-3.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import "ParkingDetailViewController.h"
#import "GetParkingDetailRequestParameter.h"
#import "ParkingDetailResponseParameter.h"
#import "UserInformation.h"
#import "CommunicationManager.h"
#import "CommonUtilities.h"
#import "CommonConsts.h"
#import "MyCommunityParameter.h"
#import "SelectionCell.h"
#import "RenewTimeInformation.h"
#import "ParkingPayRequestParameter.h"
#import "AliPayHelper.h"
#import "OptionCell.h"
#import "PayParameter.h"
#import "PayFinishViewController.h"

#define WEB_PAY_SEGUE_IDENTIFIER                    @"Web"
#define PAY_FINISH_SEGUE_IDENTIFIER                 @"Finish"
#define PAY_RETURN_BUTTON_TEXT                      @"返回缴费中心"


@interface ParkingDetailViewController ()

- (void)refreshRenewInformation;
- (void)constructSelectionTable;
- (void)showSelectionTable;
- (void)payFinish;
//- (void)popView;

@end

@implementation ParkingDetailViewController
@synthesize labelBrandName, labelCarNo, labelCommunityName, labelExpirationTime, labelOwnerName, labelPrice, labelRenewTime, labelRoomNo, labelTotalFee, parking, viewMask, labelPayName, centerController;

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
    
    NSMutableArray *temp = [NSMutableArray array];
    for(int i = 1; i < 13; i ++)
    {
        RenewTimeInformation *rti = [[RenewTimeInformation alloc] init];
        rti.title = [NSString stringWithFormat:@"%d个月",i];
        rti.time = i;
        [temp addObject:rti];
    }
    
    renewSelections = temp;
    currentRenewSelected = 0;
    currentSelectPayIndex = -1;
}

- (void)viewDidAppear:(BOOL)animated
{
    if(webPayController == nil){
        GetParkingDetailRequestParameter *request = [[GetParkingDetailRequestParameter alloc] init];
        request.billId = self.parking.billId;
        request.userId = [UserInformation instance].userId;
        request.password = [UserInformation instance].password;
        
        [[CommunicationManager instance] getParkingDetail:request withDelegate:self];
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

- (IBAction)selectRenew:(id)sender
{
    currentType = parkingSelectRenew;
    [self showSelectionTable];
}

- (IBAction)selectPay:(id)sender
{
    currentType = parkingSelectPay;
    [self showSelectionTable];
}

- (IBAction)touchPay:(id)sender
{
    if(currentSelectPayIndex < 0){
        [self showErrorMessage:@"请选择一种支付方式"];
    }
    else{
        RenewTimeInformation *info = [renewSelections objectAtIndex:currentRenewSelected];
        
        ParkingPayRequestParameter *request = [[ParkingPayRequestParameter alloc] init];
        request.userId = [UserInformation instance].userId;
        request.password = [UserInformation instance].password;
        request.billId = self.parking.billId;
        PayParameter *payParam = [currentResponse.pays objectAtIndex:currentSelectPayIndex];
        PayType type = [payParam.payId intValue];
        request.payType = type;
        request.totalFee = [self.labelTotalFee.text floatValue];
        request.month = info.time;
        [[CommunicationManager instance] payParkings:request withDelegate:self];
        [[CommonUtilities instance] showNetworkConnecting:self];
    }

}

#pragma mark - Data table Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(currentType == parkingSelectRenew){
        return [renewSelections count];
    }
    else{
        if(currentResponse == nil){
            return 0;
        }
        else{
            return [currentResponse.pays count];
        }
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(currentType == parkingSelectRenew){
        SelectionCell *cell = [tableView dequeueReusableCellWithIdentifier:SELECTION_CELL_REUSE_IDENTIFIER forIndexPath:indexPath];
        
        RenewTimeInformation *info = [renewSelections objectAtIndex:indexPath.row];
        UIImage *image = indexPath.row == currentRenewSelected ? [UIImage imageNamed: SELECTION_DEFAULT_SELECT_IMAGE_NAME] : [UIImage imageNamed:SELECTION_DEFAULT_UNSELECT_IMAGE_NAME];
        [cell setOptionString:info.title withImage:image];
        return cell;
    }
    else{
        OptionCell *cell = [tableView dequeueReusableCellWithIdentifier:OPTION_CELL_REUSE_IDENTIFIER forIndexPath:indexPath];
        PayParameter *param = [currentResponse.pays objectAtIndex:indexPath.row];
        [cell setOptionString:param.payName];
        return cell;
    }
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(currentType == parkingSelectRenew){
        currentRenewSelected = indexPath.row;
        [self refreshRenewInformation];
    }
    else{
        currentSelectPayIndex = indexPath.row;
        PayParameter *pay = [currentResponse.pays objectAtIndex:currentSelectPayIndex];
        self.labelPayName.text = pay.payName;
    }
    tableOptions.hidden = YES;
    self.viewMask.hidden = YES;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if(currentType == parkingSelectRenew){
        return 0;
    }
    else{
        return 44;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if(currentType == parkingSelectPay){
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableOptions.bounds.size.width, 44)];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, view.frame.size.width, 44)];

        label.text = @"    请选择支付方式";
        view.backgroundColor = [UIColor blackColor];
        label.textColor = [UIColor whiteColor];
        label.backgroundColor = [UIColor clearColor];
        [view addSubview:label];

        return view;
    }
    else{
        return nil;
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
            [[AliPayHelper instance] payProduct:[NSString stringWithFormat:@"%@%@",self.parking.expirationTime,@"停车费"] withTradeNo:sr.response andPrice:self.labelTotalFee.text];
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
        self.labelRoomNo.text = [NSString stringWithFormat:ROOM_NO_FORMAT,currentResponse.buildNo,currentResponse.floorNo,currentResponse.roomNo];
        self.labelOwnerName.text = currentResponse.ownerName;
        self.labelBrandName.text = currentResponse.brand;
        self.labelCarNo.text = currentResponse.carNo;
        self.labelExpirationTime.text = currentResponse.expirationTime;
        self.labelPrice.text = [NSString stringWithFormat:PARKING_PRICE_FORMAT,currentResponse.price];
        [self refreshRenewInformation];
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

- (void)refreshRenewInformation
{
    RenewTimeInformation *info = [renewSelections objectAtIndex:currentRenewSelected];
    self.labelRenewTime.text = info.title;
    self.labelTotalFee.text = [NSString stringWithFormat:@"%.2f",self.parking.price * info.time];
}

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
    [tableOptions registerClass:[SelectionCell class] forCellReuseIdentifier:SELECTION_CELL_REUSE_IDENTIFIER];
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

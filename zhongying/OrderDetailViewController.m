//
//  OrderDetailViewController.m
//  zhongying
//
//  Created by lk on 14-4-24.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import "OrderDetailViewController.h"
#import "CommonUtilities.h"
#import "UserInformation.h"
#import "CommonConsts.h"
#import "CommonHelper.h"
#import "OrderDetailRequestParameter.h"
#import "DeleteOrderRequestParameter.h"
#import "EditOrderRequestParameter.h"
#import "AddressParameter.h"
#import "PayParameter.h"
#import "ShipParameter.h"
#import "OptionCell.h"
#import "ProductCell.h"
#import "ProductDetailViewController.h"
#import "ProductParameter.h"
#import "OrderPayRequestParameter.h"
#import "StringResponse.h"
#import "AliPayHelper.h"
#import "PayFinishViewController.h"
#import "GroupViewController.h"

#define PRODUCT_CELL_REUSE_IDENTIFIER           @"Product"
#define PRODUCT_DETAIL_CELL_REUSE_IDENTIFIER    @"ProductDetail"

#define ADDRESS_SEGUE_IDENTIFIER                @"Address"
#define DETAIL_SEGUE_IDENTIFIER                 @"Detail"
#define WEB_PAY_SEGUE_IDENTIFIER                @"Web"
#define PAY_FINISH_SEGUE_IDENTIFIER             @"Finish"

@interface OrderDetailViewController ()
- (void)sendGetOrderDetailRequest;
- (void)sendEditOrderRequest;
- (void)sendDeleteOrderRequest;
- (void)constructSelectionTable;
- (void)showSelectionTable;

- (void)calculateTotalPrice;
- (void)updateButtonStatus;

- (void)payFinish;
//- (void)popView;
@end

@implementation OrderDetailViewController
@synthesize labelAddress, labelInsurePrice, labelOrderPrice, labelPayPrice, labelPayType, labelPhone, labelReceiverName, labelShipPrice, labelShipType, labelSummaryProductPrice,labelSnNo,labelStatus, attributeHeight, productHeight, tableProducts, orderId, buttonCancel, buttonModify, buttonPay, finishController;

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
    initialHeight = self.attributeHeight.constant;
    isInitial = YES;
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
    else{
        [self sendGetOrderDetailRequest];
    }
    payWeb = nil;
}

#pragma mark - Button Actions

- (IBAction)selectPay:(id)sender
{
    if(isEditable){
        editType = orderPay;
        [self showSelectionTable];
    }
}

- (IBAction)selectShip:(id)sender
{
    if(isEditable){
        editType = orderShip;
        [self showSelectionTable];
    }
}

- (IBAction)selectAddress:(id)sender
{
    if(isEditable){
        editType = orderAddress;
        [self performSegueWithIdentifier:ADDRESS_SEGUE_IDENTIFIER sender:nil];
    }
}

- (IBAction)selectDetail:(id)sender
{
    [self performSegueWithIdentifier:DETAIL_SEGUE_IDENTIFIER sender:nil];
}

- (IBAction)editOrder:(id)sender
{
    [self sendEditOrderRequest];
}

- (IBAction)deleteOrder:(id)sender
{
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"温馨提示"
                                                   message:@"是否取消订单"
                                                  delegate:self
                                         cancelButtonTitle:@"取消"
                                         otherButtonTitles:@"确定",nil];
    
    [alert show];
}

- (IBAction)payOrder:(id)sender
{
    OrderPayRequestParameter *request = [[OrderPayRequestParameter alloc] init];
    request.userId = [UserInformation instance].userId;
    request.password = [UserInformation instance].password;
    request.billId = currentResponse.orderId;
    request.payType = [currentSelectPayId intValue];
    request.totalFee = [currentResponse.orderPrice floatValue];
    [[CommunicationManager instance] payOrder:request withDelegate:self];
    [[CommonUtilities instance] showNetworkConnecting:self];
}

#pragma mark - Private Methods

- (void)sendGetOrderDetailRequest
{
    currentMode = orderGetMode;
    
    currentResponse = nil;
    OrderDetailRequestParameter *request = [[OrderDetailRequestParameter alloc] init];
    request.userId = [UserInformation instance].userId;
    request.password = [UserInformation instance].password;
    request.orderId = self.orderId;
    [[CommunicationManager instance] getOrderDetail:request withDelegate:self];
    [[CommonUtilities instance] showNetworkConnecting:self];
}

- (void)sendEditOrderRequest
{
    currentMode = orderEditMode;
    
    EditOrderRequestParameter *request = [[EditOrderRequestParameter alloc] init];
    request.userId = [UserInformation instance].userId;
    request.password = [UserInformation instance].password;
    request.orderId = self.orderId;
    
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"shipId == %@",currentSelectShipId];
    
    ShipParameter *ship = [[currentResponse.ships filteredArrayUsingPredicate:predicate] firstObject];
    request.shipPrice = ship.shipPrice;
    request.expressId = ship.shipId;
    request.expressName = ship.shipName;
    request.insurePrice = ship.insurePrice;
    
    predicate = [NSPredicate predicateWithFormat:@"payId == %@",currentSelectPayId];
    
    PayParameter *pay = [[currentResponse.pays filteredArrayUsingPredicate:predicate] firstObject];
    request.payId = pay.payId;
    request.payName = pay.payName;
    
    predicate = [NSPredicate predicateWithFormat:@"addressId == %@",currentSelectAddressId];
    
    AddressParameter *address = [[currentResponse.addresses filteredArrayUsingPredicate:predicate] firstObject];
    request.addressId = address.addressId;
    
    request.orderPrice = self.labelOrderPrice.text;
    
    [[CommunicationManager instance] editOrder:request withDelegate:self];
    [[CommonUtilities instance] showNetworkConnecting:self];
}

- (void)sendDeleteOrderRequest
{
    currentMode = orderDeleteMode;
    
    DeleteOrderRequestParameter *request = [[DeleteOrderRequestParameter alloc] init];
    request.userId = [UserInformation instance].userId;
    request.password = [UserInformation instance].password;
    request.orderId = self.orderId;
    
    [[CommunicationManager instance] deleteOrder:request withDelegate:self];
    [[CommonUtilities instance] showNetworkConnecting:self];
}

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

- (void)calculateTotalPrice
{
    float productPrice = [currentResponse.productPrice floatValue];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"payId == %@",currentSelectPayId];
    
    PayParameter *pay = [[currentResponse.pays filteredArrayUsingPredicate:predicate] firstObject];
    float payPrice = [pay.feePrice floatValue];
    predicate = [NSPredicate predicateWithFormat:@"shipId == %@",currentSelectShipId];
    ShipParameter *ship = [[currentResponse.ships filteredArrayUsingPredicate:predicate] firstObject];
    
    float insurePrice = productPrice * ([[ship.insurePrice stringByReplacingOccurrencesOfString:@"%" withString:@""] floatValue] / 100);
    
    float shipPrice = [ship.shipPrice floatValue] + insurePrice;
    
    float total = productPrice + payPrice + shipPrice;
    self.labelOrderPrice.text = [NSString stringWithFormat:@"%.2f",total];
}

- (void)updateButtonStatus
{
    BOOL notModify = [initialAddressId isEqualToString:currentSelectAddressId] && [initialPayId isEqualToString:currentSelectPayId] && [initialShipId isEqualToString:currentSelectShipId];
    self.buttonModify.hidden = notModify;
    self.buttonPay.hidden = !notModify;
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
    [[CommonUtilities instance] hideMaskView];
    [self.navigationController popToViewController:self.backController animated:YES];
}
*/
#pragma mark - Table Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if(currentResponse == nil){
        return 0;
    }
    if(tableView == self.tableProducts){
        return [currentResponse.products count] * 2;
    }
    else{
        return 1;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(currentResponse == nil){
        return 0;
    }
    if(tableView == tableOptions){
        switch (editType) {
            case orderAddress:
                return [currentResponse.addresses count];
            case orderPay:
                return [currentResponse.pays count];
            case orderShip:
                return [currentResponse.ships count];
        }
    }
    else{
        return 1;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView == tableOptions){
        return 44;
    }
    else{
        if(indexPath.section % 2 == 0){
            ProductParameter *param = [currentResponse.products objectAtIndex:indexPath.section];
            return [ProductCell getHeight:param withWidth:self.tableProducts.frame.size.width];
        }
        else{
            return 23;
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if(tableView == tableOptions){
        return 44;
    }
    else{
        return 6;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView == tableOptions){
        OptionCell *cell = [tableView dequeueReusableCellWithIdentifier:OPTION_CELL_REUSE_IDENTIFIER forIndexPath:indexPath];
        
        switch (editType) {
            case orderAddress:{
            }
                break;
            case orderPay:{
                PayParameter *param = [currentResponse.pays objectAtIndex:indexPath.row];
                [cell setOptionString:param.payName];
            }
                break;
            case orderShip:{
                ShipParameter *param = [currentResponse.ships objectAtIndex:indexPath.row];
                [cell setOptionString:param.shipName];
            }
                break;
        }
        
        return cell;
    }
    else{
        if(indexPath.section % 2 == 0){
            ProductCell *cell = [tableView dequeueReusableCellWithIdentifier:PRODUCT_CELL_REUSE_IDENTIFIER forIndexPath:indexPath];
            ProductParameter *param = [currentResponse.products objectAtIndex:indexPath.section];
            [cell setCell:param withOrderType:currentResponse.orderType];
            return cell;
        }
        else{
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:PRODUCT_DETAIL_CELL_REUSE_IDENTIFIER forIndexPath:indexPath];
            return cell;
        }
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if(tableView == tableOptions){
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableOptions.bounds.size.width, 44)];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, view.frame.size.width, 44)];
        NSString *titleText = @"";
        switch (editType) {
            case orderAddress:{
            }
                break;
            case orderPay:{
                titleText = @"    请选择支付方式";
            }
                break;
            case orderShip:{
                titleText = @"    请选择配送方式";
            }
                break;
        }
        
        label.text = titleText;
        view.backgroundColor = [UIColor blackColor];
        label.textColor = [UIColor whiteColor];
        label.backgroundColor = [UIColor clearColor];
        [view addSubview:label];
        
        return view;
    }
    else{
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableOptions.bounds.size.width, 6)];
        view.backgroundColor = [UIColor clearColor];
        return view;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView == tableOptions){
        switch (editType) {
            case orderAddress:{
                
            }
                break;
            case orderPay:{
                PayParameter *pay = [currentResponse.pays objectAtIndex:indexPath.row];
                currentSelectPayId = pay.payId;
                self.labelPayType.text = pay.payName;
                self.labelPayPrice.text = pay.feePrice;
            }
                break;
            case orderShip:{
                ShipParameter *ship = [currentResponse.ships objectAtIndex:indexPath.row];
                currentSelectShipId = ship.shipId;
                self.labelShipType.text = ship.shipName;
                self.labelShipPrice.text = ship.shipPrice;
                self.labelInsurePrice.text = ship.insurePrice;
            }
                break;
        }
        [self updateButtonStatus];
        [self calculateTotalPrice];
        tableOptions.hidden = YES;
        self.viewMask.hidden = YES;
    }
    else{
        if(indexPath.section % 2 == 1){
            currentSelectProduct = indexPath.section / 2;
            [self performSegueWithIdentifier:DETAIL_SEGUE_IDENTIFIER sender:nil];
        }
        else{
            [tableView deselectRowAtIndexPath:indexPath animated:NO];
        }
    }
}


#pragma mark - Communication Delegate

- (void)ProcessServerResponse:(id)response
{
    if([response isKindOfClass:[StringResponse class]]){
        StringResponse *sr = (StringResponse *)response;
        PayType type = [currentSelectPayId intValue];
        if(type == payZhiFuBaoWeb){
            payUrl = sr.response;
            [self performSegueWithIdentifier:WEB_PAY_SEGUE_IDENTIFIER sender:nil];
            self.hidesBottomBarWhenPushed = YES;
        }
        else if(type == payZhiFuBao){
            ProductParameter *productParam = [currentResponse.products objectAtIndex:0];
            [[AliPayHelper instance] payProduct:productParam.productName  withTradeNo:currentResponse.orderSn andPrice:currentResponse.orderPrice];
            [[AliPayHelper instance] setResultReceiver:@selector(payFinish)];
        }
        else{
            [self showErrorMessage:@"支付成功"];
            [self payFinish];
        }
    }
    else{
        if(currentMode == orderGetMode){
            currentResponse = response;
            if(selectAddressController != nil){
                currentSelectAddressId = selectAddressController.selectAddressId;
            }
            if(isInitial){
                self.labelReceiverName.text = currentResponse.receiverName;
                self.labelPhone.text = currentResponse.phone;
                self.labelAddress.text = currentResponse.address;
                
                initialAddressId = currentResponse.addressId;
                currentSelectAddressId = currentResponse.addressId;
                
                initialPayId = currentResponse.payId;
                currentSelectPayId = currentResponse.payId;
                
                self.labelPayType.text = currentResponse.payName;
                for(int i = 0; i < [currentResponse.pays count]; i++){
                    PayParameter *param = [currentResponse.pays objectAtIndex:i];
                    if([param.payId isEqualToString:currentResponse.payId]){
                        self.labelPayPrice.text = param.feePrice;
                        break;
                    }
                }
                
                isEditable = true;
                NSRange rangeCancel = [currentResponse.status rangeOfString:@"已取消"];
                NSRange rangeReturn = [currentResponse.status rangeOfString:@"退货"];
                self.buttonModify.hidden = YES;
                if(rangeCancel.length != 0 || rangeReturn.length != 0){
                    self.buttonCancel.superview.hidden = YES;
                    self.bottom.constant = 8;
                    isEditable = false;
                }
                NSRange rangeConfirm = [currentResponse.status rangeOfString:@"已确认"];
                if(rangeConfirm.length != 0){
                    isEditable = false;
                    NSRange rangeUnpay = [currentResponse.status rangeOfString:@"未付款"];
                    if(rangeUnpay.length != 0){
                        self.buttonCancel.hidden = YES;
                    }
                    else{
                        self.buttonCancel.superview.hidden = YES;
                        self.bottom.constant = 8;
                    }
                }

                self.labelShipType.text = currentResponse.expressName;
                self.labelShipPrice.text = currentResponse.shipPrice;
                self.labelInsurePrice.text = currentResponse.insurePrice;
                
                initialShipId = currentResponse.shipId;
                currentSelectShipId = currentResponse.shipId;
                self.labelOrderPrice.text = currentResponse.orderPrice;
                isInitial = NO;
            }
            else{
                NSPredicate *predicate = [NSPredicate predicateWithFormat:@"addressId == %@",currentSelectAddressId];
                AddressParameter *address = [[currentResponse.addresses filteredArrayUsingPredicate:predicate] firstObject];
                self.labelReceiverName.text = address.name;
                self.labelPhone.text = address.phone;
                self.labelAddress.text = [NSString stringWithFormat:@"%@%@%@%@",address.provinceName,address.cityName,address.districtName,address.address];
                
                predicate = [NSPredicate predicateWithFormat:@"payId == %@",currentSelectPayId];
                PayParameter *pay = [[currentResponse.pays filteredArrayUsingPredicate:predicate] firstObject];
                self.labelPayType.text = pay.payName;
                self.labelPayPrice.text = pay.feePrice;
                
                predicate = [NSPredicate predicateWithFormat:@"shipId == %@",currentSelectShipId];
                ShipParameter *ship = [[currentResponse.ships filteredArrayUsingPredicate:predicate]firstObject];
                self.labelShipType.text = ship.shipName;
                self.labelShipPrice.text = ship.shipPrice;
                self.labelInsurePrice.text = ship.insurePrice;
                
                [self calculateTotalPrice];
            }
            
            self.labelSummaryProductPrice.text = currentResponse.productPrice;
            self.labelSnNo.text = currentResponse.orderSn;
            self.labelStatus.text = currentResponse.status;
            
            [self.tableProducts reloadData];
            self.productHeight.constant = self.tableProducts.contentSize.height;
            self.attributeHeight.constant = initialHeight + self.tableProducts.contentSize.height;
            //CGRect tableFrame = self.tableProducts.frame;
            //tableFrame.size.height = self.tableProducts.contentSize.height;
            //self.tableProducts.frame = tableFrame;
        }
        else if(currentMode == orderEditMode){
            isInitial = YES;
            [self showErrorMessage:@"修改成功"];
            [self sendGetOrderDetailRequest];
        }
        else if(currentMode == orderDeleteMode){
            [[CommonUtilities instance] showGlobeMessage:@"取消成功"];
            [self.navigationController popViewControllerAnimated:YES];
        }
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

#pragma mark - Alert View Delegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex > 0){
        [self sendDeleteOrderRequest];
    }
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.destinationViewController isKindOfClass:[AddressesViewController class]]){
        selectAddressController = segue.destinationViewController;
        selectAddressController.isSelect = YES;
    }
    else if([segue.destinationViewController isKindOfClass:[ProductDetailViewController class]]){
        ProductDetailViewController *controller = (ProductDetailViewController *)segue.destinationViewController;
        
        ProductParameter *product = [currentResponse.products objectAtIndex:currentSelectProduct];
        controller.productId = product.productId;
        controller.productDetailUrl = currentResponse.detailUrl;
    }
    else if([segue.destinationViewController isKindOfClass:[ZhiFuBaoWebViewController class]]){
        ZhiFuBaoWebViewController *controller = (ZhiFuBaoWebViewController *)segue.destinationViewController;
        payWeb = controller;
        controller.url = payUrl;
    }
    else if([segue.destinationViewController isKindOfClass:[PayFinishViewController class]]){
        PayFinishViewController *controller = (PayFinishViewController *)segue.destinationViewController;
        controller.backController = self.finishController;
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"payId == %@",currentSelectPayId];
        PayParameter *pay = [[currentResponse.pays filteredArrayUsingPredicate:predicate] firstObject];
        controller.payTitle = pay.payName;
        
        NSString *returnText = @"返回我的订单";
        if([self.finishController isKindOfClass:[GroupViewController class]]){
            GroupViewController *groupController = (GroupViewController *)self.finishController;
            returnText = groupController.isGroup ? @"返回团购列表" : @"返回预定列表";
        }
        controller.returnText = returnText;
    }
}


@end

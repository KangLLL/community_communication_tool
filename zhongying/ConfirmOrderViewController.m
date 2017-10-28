//
//  ConfirmOrderViewController.m
//  zhongying
//
//  Created by lk on 14-4-23.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import "ConfirmOrderViewController.h"
#import "CommonUtilities.h"
#import "UserInformation.h"
#import "CommonConsts.h"
#import "ConfirmOrderRequestParameter.h"
#import "AddressParameter.h"
#import "PayParameter.h"
#import "ShipParameter.h"
#import "OptionCell.h"
#import "ProductDetailViewController.h"
#import "AddGroupOrderRequestParameter.h"
#import "AddOrderViewController.h"
/*
#import "OrderAddressCell.h"
#import "OrderPayCell.h"
#import "OrderShipCell.h"
#import "OrderProductInformationCell.h"
#import "OrderSummaryCell.h"


#define ADDRESS_CELL_REUSE_IDENTIFIER       @"Address"
#define PAY_CELL_REUSE_IDENTIFIER           @"Pay"
#define SHIP_CELL_REUSE_IDENTIFIER          @"Ship"
#define INFORMATION_CELL_REUSE_IDENTIFIER   @"Information"
#define DETAIL_CELL_REUSE_IDENTIFIER        @"Detail"
#define SUMMARY_CELL_REUSE_IDENTIFIER       @"Summary"
*/

#define ADDRESS_SEGUE_IDENTIFIER            @"Address"
#define DETAIL_SEGUE_IDENTIFIER             @"Detail"
#define ADD_ORDER_SEGUE_IDENTIFIER          @"Add"

@interface ConfirmOrderViewController ()

- (void)sendConfirmOrderRequest;
- (void)sendAddOrderRequest;
- (void)constructSelectionTable;
- (void)showSelectionTable;

@end

@implementation ConfirmOrderViewController

@synthesize labelAddress, labelInsurePrice, labelOrderPrice, labelPayPrice, labelPayType, labelPhone, labelProductName, labelReceiverName, labelShipPrice, labelShipType, labelSummaryDiscount, labelSummaryProductPrice, labelSummaryShipPrice, orderInfo, viewAttributeParent, attributeHeight, listController;

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
    
    if([self.orderInfo.allAttributeDescription length] > 0){
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(6, 45, 300, 12)];
        NSString *attributeText = [NSString stringWithFormat:@"%@:%@",@"属性",self.orderInfo.allAttributeDescription];
        label.backgroundColor = [UIColor clearColor];
        [label setFont:[UIFont systemFontOfSize:10]];
        label.lineBreakMode = NSLineBreakByWordWrapping;
        label.numberOfLines = 0;
        CGSize textSize = [attributeText sizeWithFont:[UIFont systemFontOfSize:10] constrainedToSize:CGSizeMake(300, 10000) lineBreakMode:NSLineBreakByWordWrapping];
        self.attributeHeight.constant += (6 + textSize.height);
        
        label.text = attributeText;
        [self.viewAttributeParent addSubview:label];
    }
    
   
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated
{
    [self sendConfirmOrderRequest];
}

#pragma mark - Button Actions

- (IBAction)selectPay:(id)sender
{
    editType = orderPay;
    [self showSelectionTable];
}

- (IBAction)selectShip:(id)sender
{
    editType = orderShip;
    [self showSelectionTable];
}

- (IBAction)selectAddress:(id)sender
{
    editType = orderAddress;
    [self performSegueWithIdentifier:ADDRESS_SEGUE_IDENTIFIER sender:nil];
}

- (IBAction)selectDetail:(id)sender
{
    [self performSegueWithIdentifier:DETAIL_SEGUE_IDENTIFIER sender:nil];
}

- (IBAction)addOrder:(id)sender
{
    [self sendAddOrderRequest];
}

#pragma mark - Private Methods

- (void)sendConfirmOrderRequest
{
    currentResponse = nil;
    ConfirmOrderRequestParameter *request = [[ConfirmOrderRequestParameter alloc] init];
    request.userId = [UserInformation instance].userId;
    request.password = [UserInformation instance].password;
    request.productId = self.orderInfo.productId;
    request.count = self.orderInfo.count;
    request.attribute = self.orderInfo.singleSelectAttributes;
    request.limitRestrict = self.orderInfo.limitRestrict;
    request.groupId = self.orderInfo.groupId;
    request.isGroup = self.orderInfo.isGroup;
    [[CommunicationManager instance] confirmOrder:request withDelegate:self];
    [[CommonUtilities instance] showNetworkConnecting:self];
}

- (void)sendAddOrderRequest
{
    if([self.labelAddress.text length] == 0){
        [self showErrorMessage:@"请选择一个收货地址"];
    }
    else if([self.labelPayType.text length] == 0){
        [self showErrorMessage:@"请选择一种支付方式"];
    }
    else if([self.labelShipType.text length] == 0){
        [self showErrorMessage:@"请选择一种配送方式"];
    }
    else{
        if(self.listController.isGroup){
            AddGroupOrderRequestParameter *request = [[AddGroupOrderRequestParameter alloc] init];
            request.productId = self.orderInfo.productId;
            AddressParameter *address = [currentResponse.addresses objectAtIndex:currentSelectAddressIndex];
            request.userId = [UserInformation instance].userId;
            request.password = [UserInformation instance].password;
            request.addressId = address.addressId;
            request.count = self.orderInfo.count;
            request.attribute = self.orderInfo.singleSelectAttributes;
            request.productAttribute = self.orderInfo.allProductAttributes;
            ShipParameter *ship = [currentResponse.ships objectAtIndex:currentSelectShipIndex];
            request.expressId = ship.shipId;
            request.expressName = ship.shipName;
            PayParameter *pay = [currentResponse.pays objectAtIndex:currentSelectPayIndex];
            request.payId = pay.payId;
            request.payName = pay.payName;
            request.productPrice = self.labelSummaryProductPrice.text;
            request.orderPrice = self.labelOrderPrice.text;
            request.shipPrice = self.labelShipPrice.text;
            request.insurePrice = self.labelInsurePrice.text;
            request.groupId = self.orderInfo.buyId;
            
            
            [[CommunicationManager instance] addGroupOrder:request withDelegate:self];
        }
        else{
            AddReserveOrderRequestParameter *request = [[AddReserveOrderRequestParameter alloc] init];
            request.productId = self.orderInfo.productId;
            AddressParameter *address = [currentResponse.addresses objectAtIndex:currentSelectAddressIndex];
            request.userId = [UserInformation instance].userId;
            request.password = [UserInformation instance].password;
            request.addressId = address.addressId;
            request.count = self.orderInfo.count;
            request.attribute = self.orderInfo.singleSelectAttributes;
            request.productAttribute = self.orderInfo.allProductAttributes;
            ShipParameter *ship = [currentResponse.ships objectAtIndex:currentSelectShipIndex];
            request.expressId = ship.shipId;
            request.expressName = ship.shipName;
            PayParameter *pay = [currentResponse.pays objectAtIndex:currentSelectPayIndex];
            request.payId = pay.payId;
            request.payName = pay.payName;
            request.productPrice = self.labelSummaryProductPrice.text;
            request.orderPrice = self.labelOrderPrice.text;
            request.shipPrice = self.labelShipPrice.text;
            request.insurePrice = self.labelInsurePrice.text;
            request.reserveId = self.orderInfo.buyId;
            
            [[CommunicationManager instance] addReserveOrder:request withDelegate:self];
        }
        [[CommonUtilities instance] showNetworkConnecting:self];
    }
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

#pragma mark - Table Delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(currentResponse == nil){
        return 0;
    }
    switch (editType) {
        case orderAddress:
            return [currentResponse.addresses count];
        case orderPay:
            return [currentResponse.pays count];
        case orderShip:
            return [currentResponse.ships count];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
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

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (editType) {
        case orderAddress:{
            
        }
            break;
        case orderPay:{
            currentSelectPayIndex = indexPath.row;
            PayParameter *pay = [currentResponse.pays objectAtIndex:currentSelectPayIndex];
            self.labelPayType.text = pay.payName;
            self.labelPayPrice.text = pay.feePrice;
            
        }
            break;
        case orderShip:{
            currentSelectShipIndex = indexPath.row;
            ShipParameter *ship = [currentResponse.ships objectAtIndex:currentSelectShipIndex];
            self.labelShipType.text = ship.shipName;
            self.labelShipPrice.text = ship.shipPrice;
            self.labelInsurePrice.text = ship.insurePrice;
            
            float insurePrice = [orderInfo.productPrice floatValue] * ([[ship.insurePrice stringByReplacingOccurrencesOfString:@"%" withString:@""] floatValue] / 100);
            
            float totalShipPrice = [ship.shipPrice floatValue] + insurePrice;
            self.labelSummaryShipPrice.text = [NSString stringWithFormat:@"%.2f",totalShipPrice];
            float total = ([orderInfo.productPrice floatValue]+ orderInfo.totalAttributePrice) * orderInfo.count + totalShipPrice;
            self.labelOrderPrice.text = [NSString stringWithFormat:@"%.2f",total];
        }
            break;
    }
    
    tableOptions.hidden = YES;
    self.viewMask.hidden = YES;
}


#pragma mark - Communication Delegate

- (void)ProcessServerResponse:(id)response
{
    if([response isKindOfClass:[ConfirmOrderResponseParameter class]]){
        currentResponse = response;
        if(selectAddressController != nil){
            for(int i = 0; i < [currentResponse.addresses count]; i ++){
                AddressParameter *param = [currentResponse.addresses objectAtIndex:i];
                if([param.addressId isEqualToString:selectAddressController.selectAddressId]){
                    currentSelectAddressIndex = i;
                    break;
                }
            }
        }
        if([currentResponse.addresses count] > 0){
            AddressParameter *address = [currentResponse.addresses objectAtIndex:currentSelectAddressIndex];
            self.labelReceiverName.text = address.name;
            self.labelPhone.text = address.phone;
            self.labelAddress.text = address.address;
        }
        
        PayParameter *pay = [currentResponse.pays objectAtIndex:currentSelectPayIndex];
        self.labelPayType.text = pay.payName;
        self.labelPayPrice.text = pay.feePrice;
        
        float total = ([orderInfo.productPrice floatValue] + orderInfo.totalAttributePrice) * orderInfo.count;
        
        if([currentResponse.ships count] > 0){
            ShipParameter *ship = [currentResponse.ships objectAtIndex:currentSelectShipIndex];
            self.labelShipType.text = ship.shipName;
            self.labelShipPrice.text = ship.shipPrice;
            self.labelInsurePrice.text = ship.insurePrice;
            
            float totalShipPrice = [ship.shipPrice floatValue] + [ship.insurePrice floatValue];
            self.labelSummaryShipPrice.text = [NSString stringWithFormat:@"%.2f",totalShipPrice];
            total += totalShipPrice;
        }
        
        self.labelSummaryProductPrice.text = [NSString stringWithFormat:@"%.2f", ([orderInfo.productPrice floatValue] + orderInfo.totalAttributePrice) * orderInfo.count];
        self.labelSummaryDiscount.text = @"0";
        
        self.labelOrderPrice.text = [NSString stringWithFormat:@"%.2f",total];
        

        self.labelProductName.text = self.orderInfo.productName;
    }
    else{
        addOrderResponse = response;
        [self performSegueWithIdentifier:ADD_ORDER_SEGUE_IDENTIFIER sender:nil];
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
    if([segue.destinationViewController isKindOfClass:[AddressesViewController class]]){
        selectAddressController = segue.destinationViewController;
        selectAddressController.isSelect = YES;
    }
    else if([segue.destinationViewController isKindOfClass:[ProductDetailViewController class]]){
        ProductDetailViewController *controller = (ProductDetailViewController *)segue.destinationViewController;
        controller.productId = self.orderInfo.productId;
        controller.productDetailUrl = self.orderInfo.detailUrl;
    }
    else if([segue.destinationViewController isKindOfClass:[AddOrderViewController class]]){
        AddOrderViewController *controller = (AddOrderViewController *)segue.destinationViewController;
        controller.orderPrice = self.labelOrderPrice.text;
        controller.payName = self.labelPayType.text;
        PayParameter *pay = [currentResponse.pays objectAtIndex:currentSelectPayIndex];
        controller.payType = [pay.payId intValue];
        controller.productName = self.orderInfo.productName;
        controller.currentResponse = addOrderResponse;
        controller.backController = listController;
    }
}


@end

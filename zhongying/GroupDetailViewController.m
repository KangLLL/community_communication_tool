//
//  GroupDetailViewController.m
//  zhongying
//
//  Created by lk on 14-4-20.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import "GroupDetailViewController.h"
#import "CommonUtilities.h"
#import "UserInformation.h"
#import "CommonHelper.h"
#import "GroupDetailHeadCell.h"
#import "GroupDetailSuggestCell.h"
#import "GroupDetailRequestParameter.h"
#import "ReserveDetailRequestParameter.h"
#import "ProductDetailViewController.h"
#import "GroupAttributeCell.h"
#import "ProductAttributeParameter.h"
#import "ConfirmOrderViewController.h"
#import "AddOrderInformation.h"
#import "ProductOptionParameter.h"

#define GROUP_HEAD_CELL_REUSE_IDENTIFIER            @"Head"
#define GROUP_CONTENT_CELL_REUSE_IDENTIFIER         @"Content"
#define ATTRIBUTE_CELL_REUSE_IDENTIFIER             @"Attribute"
#define GROUP_BUTTON_CELL_REUSE_IDENTIFIER          @"Button"
#define GROUP_SUGGEST_HEAD_CELL_REUSE_IDENTIFIER    @"Suggest Head"
#define GROUP_SUGGEST_CONTENT_CELL_REUSE_IDENTIFIER @"Suggest"
#define PRODUCT_DETAIL_SEGUE_IDENTIFIER             @"Detail"
#define BUY_SEGUE_IDENTIFIER                        @"Buy"

@interface GroupDetailViewController ()

- (void)sendGetDetailRequest;
- (void)sendConfirmOrderRequest;

@end

@implementation GroupDetailViewController

@synthesize tableInformations, groupList;

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
    self.tableInformations.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    cacher = [[DownloadCacher alloc] init];
    quantity = 1;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated
{
    [self sendGetDetailRequest];
}

#pragma mark - Private Methods

- (void)sendGetDetailRequest
{
    if(currentResponse == nil){
        if(groupList.isGroup){
            GroupDetailRequestParameter *request = [[GroupDetailRequestParameter alloc] init];
            request.userId = [UserInformation instance].userId;
            request.password = [UserInformation instance].password;
            request.groupId = self.groupId;
            
            [[CommunicationManager instance] getGroupDetail:request withDelegate:self];
            [[CommonUtilities instance] showNetworkConnecting:self];
        }
        else{
            ReserveDetailRequestParameter *request = [[ReserveDetailRequestParameter alloc] init];
            request.userId = [UserInformation instance].userId;
            request.password = [UserInformation instance].password;
            request.reserveId = self.groupId;
            
            [[CommunicationManager instance] getReserveDetail:request withDelegate:self];
            [[CommonUtilities instance] showNetworkConnecting:self];
        }
    }
}

- (void)sendConfirmOrderRequest
{
    isConfirming = YES;
    ConfirmOrderRequestParameter *request = [[ConfirmOrderRequestParameter alloc] init];
    request.userId = [UserInformation instance].userId;
    request.password = [UserInformation instance].password;
    request.productId = currentResponse.productId;
    request.count = quantity;
    request.limitRestrict = currentResponse.limitRestrict;
    request.groupId = self.groupId;
    request.isGroup = self.groupList.isGroup;
    AddOrderInformation *orderInfo = [[AddOrderInformation alloc] init];
    if(cellAttribute != nil){
        [orderInfo setAttributesBySelection:[cellAttribute getSelections] withProduct:currentResponse.attributes];
    }
    else{
        [orderInfo setAttributesBySelection:[NSArray array] withProduct:currentResponse.attributes];
    }
    request.attribute = orderInfo.singleSelectAttributes;

    [[CommunicationManager instance] confirmOrder:request withDelegate:self];
    [[CommonUtilities instance] showNetworkConnecting:self];
}

#pragma mark - Data table Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(currentResponse == nil){
        return 0;
    }
    else{
        int result = 3;
        
        if([currentResponse.attributes count] > 0){
            result += 1;
        }
        if([currentResponse.suggestions count] > 0){
            result += ([currentResponse.suggestions count] - 1) / 3 + 2;
        }
        return result;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BOOL haveAttribute = currentResponse != nil && [currentResponse.attributes count] > 0;
    
    if(indexPath.row == 0){
        return 100;
    }
    else if(indexPath.row == 1){
        return 120;
    }
    else if(indexPath.row == 2){
        if(haveAttribute){
            return [GroupAttributeCell getCellHeightOfAttributes:currentResponse.attributes withContentWidth:320];
        }
        else{
            return 78;
        }
    }
    else if(indexPath.row == 3){
        if(haveAttribute){
            return 78;
        }
        else{
            return 28;
        }
    }
    else if(indexPath.row == 4 && haveAttribute){
        return 28;
    }
    else{
        return 140;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    BOOL haveAttribute = currentResponse != nil && [currentResponse.attributes count] > 0;
    if(indexPath.row == 0){
        GroupDetailHeadCell *cell = [tableView dequeueReusableCellWithIdentifier:GROUP_HEAD_CELL_REUSE_IDENTIFIER forIndexPath:indexPath];
        [cacher getImageWithUrl:currentResponse.imageUrl andCell:cell inImageView:cell.imagePhoto withActivityView:cell.activityView];
        cell.tag = indexPath.row;
        return cell;
    }
    else if(indexPath.row == 1){
        GroupDetailContentCell *cell = [tableView dequeueReusableCellWithIdentifier:GROUP_CONTENT_CELL_REUSE_IDENTIFIER forIndexPath:indexPath];
        cell.labelTitle.text = currentResponse.productName;
        [cell setFinishTime:[NSDate dateWithTimeIntervalSince1970:[currentResponse.finishTime longLongValue]]];
        
        [cell setInfomation:currentResponse.originalPrice andGroupPrice:currentResponse.groupPrice withDiscount:currentResponse.discount withRestrict:currentResponse.maxRestrict];
        
        cell.labelPriceTitle.text = self.groupList.isGroup ? @"团购价" : @"预定价";
        
        labelQuantity = cell.labelQuantity;
        labelGroupPrice = cell.labelGroupPrice;
        contentCell = cell;
        return cell;
    }
    else if(indexPath.row == 2){
        if(haveAttribute){
            GroupAttributeCell *cell = [tableView dequeueReusableCellWithIdentifier:ATTRIBUTE_CELL_REUSE_IDENTIFIER forIndexPath:indexPath];
            [cell setAttributes:currentResponse.attributes];
            cellAttribute = cell;
            return cell;
        }
        else{
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:GROUP_BUTTON_CELL_REUSE_IDENTIFIER forIndexPath:indexPath];
            return cell;
        }
    }
    else if(indexPath.row == 3){
        if(haveAttribute){
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:GROUP_BUTTON_CELL_REUSE_IDENTIFIER forIndexPath:indexPath];
            return cell;
        }
        else{
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:GROUP_SUGGEST_HEAD_CELL_REUSE_IDENTIFIER forIndexPath:indexPath];
            return cell;
        }
    }
    else if(indexPath.row == 4 && haveAttribute){
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:GROUP_SUGGEST_HEAD_CELL_REUSE_IDENTIFIER forIndexPath:indexPath];
        return cell;
    }
    else{
        GroupDetailSuggestCell *cell = [tableView dequeueReusableCellWithIdentifier:GROUP_SUGGEST_CONTENT_CELL_REUSE_IDENTIFIER forIndexPath:indexPath];
        
        int suggestStartIndex = haveAttribute ? 5 : 4;
        int section = indexPath.row - suggestStartIndex;
        
        NSMutableArray *suggestions = [NSMutableArray array];
        for(int i = 0; i < 3; i ++){
            int index = section * 3 + i;
            if(index == [currentResponse.suggestions count]){
                break;
            }
            else{
                [suggestions addObject:[currentResponse.suggestions objectAtIndex:index]];
            }
        }
        cell.tag = indexPath.row;
        [cell setSuggestions:suggestions withCacher:cacher];
        
        return cell;
    }
}

- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath
{
    return NO;
}

#pragma mark - Button Actions

- (IBAction)addQuantity:(id)sender
{
    float onePiecePrice = [labelGroupPrice.text floatValue];
    quantity = MIN(quantity + 1, currentResponse.maxRestrict);
    labelQuantity.text = [NSString stringWithFormat:@"%d", quantity];
    [contentCell setTotalPrice:onePiecePrice * quantity];
}

- (IBAction)subQuantity:(id)sender
{
    float onePiecePrice = [labelGroupPrice.text floatValue];
    quantity = MAX(1, quantity - 1);
    labelQuantity.text = [NSString stringWithFormat:@"%d", quantity];
    [contentCell setTotalPrice:onePiecePrice * quantity];
}

- (IBAction)displayProductDetail:(id)sender
{
    //NSLog(@"%@",[cellAttribute getSelections]);
    //NSLog(@"%@",[cellAttribute getSelectionsAttributeDescription]);
    //if([cellAttribute getInvalidSelectionString] != nil){
    //    NSLog(@"%@",[cellAttribute getInvalidSelectionString]);
    //}
    [self performSegueWithIdentifier:PRODUCT_DETAIL_SEGUE_IDENTIFIER sender:nil];
}

- (IBAction)buy:(id)sender
{
    if(cellAttribute != nil){
        NSArray *selections = [cellAttribute getSelections];
        for(int i = 0; i < [selections count]; i ++){
            NSArray *s = [selections objectAtIndex:i];
            if([s count] == 0){
                ProductAttributeParameter *attribute = [currentResponse.attributes objectAtIndex:i];
                [self showErrorMessage:[NSString stringWithFormat:@"请选择%@", attribute.attributeName]];
                return;
            }
        }
    }
    [self sendConfirmOrderRequest];
}

- (IBAction)showOtherGroup:(id)sender
{
    UIButton *button = (UIButton *)sender;
    GroupDetailSuggestCell *cell = (GroupDetailSuggestCell *)[CommonHelper getParentCell:button];
    self.groupId = [cell getSuggestionGroupId:button.tag];
    currentResponse = nil;
    [self sendGetDetailRequest];
    [self.tableInformations reloadData];
}

#pragma mark - Communication Delegate

- (void)ProcessServerResponse:(id)response
{
    if(isConfirming){
        [self performSegueWithIdentifier:BUY_SEGUE_IDENTIFIER sender:nil];
        isConfirming = NO;
    }
    else{
        currentResponse = response;
        
        [self.tableInformations reloadData];
    }
    [[CommonUtilities instance] hideNetworkConnecting];
}

- (void)ProcessServerFail:(ServerFailInformation *)failInfo
{
    [[CommonUtilities instance] hideNetworkConnecting];
    NSLog(@"%@",failInfo.message);
    [self showErrorMessage:failInfo.message];
    isConfirming = NO;
}

- (void)ProcessCommunicationError:(NSError *)error
{
    [[CommonUtilities instance] hideNetworkConnecting];
    NSLog(@"%@",error.localizedDescription);
    [self showErrorMessage:error.localizedDescription];
    isConfirming = NO;
}

#pragma mark - Attribute Delegate

- (void)attributeCellSelectionChange:(GroupAttributeCell *)cell
{
    NSArray *selections = [cell getSelections];
    float attributePrice = 0;
    for(int i = 0; i < [selections count]; i ++){
        ProductAttributeParameter *product = [currentResponse.attributes objectAtIndex:i];
        NSArray *as = [selections objectAtIndex:i];
        for(int j = 0; j < [as count]; j ++){
            ProductOptionParameter *option = [product.options objectAtIndex:[[as objectAtIndex:j] intValue]];
            attributePrice += option.optionPrice;
            
        }
    }
    
    float onePiecePrice = [currentResponse.groupPrice floatValue] + attributePrice;
    [contentCell setGroupPrice:onePiecePrice];
    [contentCell setTotalPrice:onePiecePrice * quantity];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.destinationViewController isKindOfClass:[ProductDetailViewController class]]){
        ProductDetailViewController *productViewController = (ProductDetailViewController *)segue.destinationViewController;
        productViewController.productId = currentResponse.productId;
        productViewController.productDetailUrl = currentResponse.detailUrl;
    }
    if([segue.destinationViewController isKindOfClass:[ConfirmOrderViewController class]]){
        
        AddOrderInformation *information = [[AddOrderInformation alloc] init];
        information.productId = currentResponse.productId;
        information.productName = currentResponse.productName;
        information.productPrice = currentResponse.groupPrice;
        information.limitRestrict = currentResponse.limitRestrict;
        information.groupId = self.groupId;
        information.isGroup = self.groupList.isGroup;
        information.count = quantity;
        information.buyId = currentResponse.groupId;
        information.detailUrl = currentResponse.detailUrl;
        if(cellAttribute != nil){
            [information setAttributesBySelection:[cellAttribute getSelections] withProduct:currentResponse.attributes];
        }
        else{
            [information setAttributesBySelection:[NSArray array] withProduct:currentResponse.attributes];
        }
        
        ConfirmOrderViewController *controller = (ConfirmOrderViewController *)segue.destinationViewController;
        controller.orderInfo = information;
        
        controller.listController = self.groupList;
    }
    
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


@end

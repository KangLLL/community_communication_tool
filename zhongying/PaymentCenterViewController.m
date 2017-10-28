//
//  PaymentCenterViewController.m
//  zhongying
//
//  Created by lik on 14-3-29.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import "PaymentCenterViewController.h"
#import "UserInformation.h"
#import "CommunicationManager.h"
#import "CommonUtilities.h"
#import "MyCommunityParameter.h"
#import "PaymentUtilitiesCell.h"
#import "PaymentParkingCell.h"
#import "PaymentReceivedExpressCell.h"
#import "PaymentUnreceivedExpressCell.h"
#import "UtilitiesParameter.h"
#import "ParkingParameter.h"
#import "ExpressParameter.h"
#import "NSDate+DateCompare.h"
#import "CommonHelper.h"
#import "UtilitiesDetailViewController.h"
#import "UtilitiesUnpayDetailViewController.h"
#import "ParkingDetailViewController.h"
#import "OptionCell.h"
#import "CommonConsts.h"
#import "CommunityInformation.h"

#define UTILITIES_REUSE_IDENTIFIER              @"Utilities"
#define PARKING_REUSE_IDENTIFIER                @"Parking"
#define EXPRESS_RECEIVED_REUSE_IDENTIFIER       @"ExpressReceived"
#define EXPRESS_UNRECEIVED_REUSE_IDENTIFIER     @"ExpressUnreceived"
#define ROOM_NO_FORMAT                          @"%@-%@-%@"

#define PAY_UTILITIES_SEGUE_IDENTIFIER          @"PayUtilities"
#define UNPAY_UTILITIES_SEGUE_IDENTIFIER        @"UnpayUtilities"
#define PARKING_SEGUE_IDENTIFIER                @"Parking"

#define OPTION_REUSE_IDENTIFIER                 @"Option"

#define TABLE_TOP_WITH_FILTER_BUTTON            49
#define TABLE_TOP_WITHOUT_FILTER_BUTTON         23

@interface PaymentCenterViewController ()

- (void)sendGetUtilitiesRequest;
- (void)sendGetParkingsRequest;
- (void)sendGetExpressRequest;

- (void)sendGetUtilitiesRequestWithPage:(int)page andPageSize:(int)pageSize;
- (void)sendGetParkingsRequestWithPage:(int)page andPageSize:(int)pageSize;
- (void)sendGetExpressRequestWithPage:(int)page andPageSize:(int)pageSize;

- (void)constructSelectionTable;
- (void)showSelectionTable;

@end

@implementation PaymentCenterViewController

@synthesize currentFunction, buttonUtilities, buttonParking, buttonExpress, tableInformations, communitiesView;

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
    self.communitiesView.selectItemImage = [UIImage imageNamed:COMMUNITY_DEFAULT_SELECT_IMAGE_NAME];
    self.communitiesView.unselectItemImage = [UIImage imageNamed:COMMUNITY_DEFAULT_UNSELECT_IMAGE_NAME];
    
    filterDescriptions = [NSArray arrayWithObjects:@"所有缴费状态",@"已缴费",@"未缴费", nil];
    [self.communitiesView reloadData];
    [self.communitiesView setSelectIndex:[UserInformation instance].currentCommunityIndex];
    
    utilitiesDataManager = [[PageDataManager alloc] initWithPageSize:DEFAULT_PAGE_SIZE];
    parkingDataManager = [[PageDataManager alloc] initWithPageSize:DEFAULT_PAGE_SIZE];
    expressDataManager = [[PageDataManager alloc] initWithPageSize:DEFAULT_PAGE_SIZE];
    
    /*
    self.buttonUtilities.layer.borderColor = [UIColor blackColor].CGColor;
    self.buttonUtilities.layer.borderWidth = 1;
    self.buttonParking.layer.borderColor = [UIColor blackColor].CGColor;
    self.buttonParking.layer.borderWidth = 1;
    self.buttonExpress.layer.borderColor = [UIColor blackColor].CGColor;
    self.buttonExpress.layer.borderWidth = 1;
    */
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated
{
    switch (self.currentFunction) {
        case paymentUtilities:
            [self.buttonUtilities setSelected:YES];
            self.tableTopMargin.constant = TABLE_TOP_WITH_FILTER_BUTTON;
            self.viewFitler.hidden = NO;
            if([[utilitiesDataManager allData] count] == 0){
                [self sendGetUtilitiesRequest];
            }
            else{
                [self sendGetUtilitiesRequestWithPage:1 andPageSize:[[utilitiesDataManager allData] count]];
                [utilitiesDataManager clear];
            }
            break;
        case paymentParking:
            [self.buttonParking setSelected:YES];
            self.tableTopMargin.constant = TABLE_TOP_WITHOUT_FILTER_BUTTON;
            self.viewFitler.hidden = YES;
            if([[parkingDataManager allData] count] == 0){
                [self sendGetParkingsRequest];
            }
            else{
                [self sendGetParkingsRequestWithPage:1 andPageSize:[[parkingDataManager allData] count]];
                [parkingDataManager clear];
            }
            break;
        case paymentExpress:
            [self.buttonExpress setSelected:YES];
            self.tableTopMargin.constant = TABLE_TOP_WITHOUT_FILTER_BUTTON;
            self.viewFitler.hidden = YES;
            if([[expressDataManager allData] count] == 0){
                [self sendGetExpressRequest];
            }
            else{
                [self sendGetExpressRequestWithPage:1 andPageSize:[[expressDataManager allData] count]];
                [expressDataManager clear];
            }
            break;
    }
}

#pragma mark - Button Actions

- (IBAction)getUtilities:(id)sender
{
    if(self.currentFunction != paymentUtilities){
        self.tableTopMargin.constant = TABLE_TOP_WITH_FILTER_BUTTON;
        self.viewFitler.hidden = NO;
        
        self.currentFunction = paymentUtilities;
        [self.buttonUtilities setSelected:YES];
        [self.buttonParking setSelected:NO];
        [self.buttonExpress setSelected:NO];
        
        if([[utilitiesDataManager allData] count] == 0){
            [self sendGetUtilitiesRequest];
        }
        else{
            [self sendGetUtilitiesRequestWithPage:1 andPageSize:[[utilitiesDataManager allData] count]];
            [utilitiesDataManager clear];
        }
    }
}

- (IBAction)getParking:(id)sender
{
    if(self.currentFunction != paymentParking){
        self.tableTopMargin.constant = TABLE_TOP_WITHOUT_FILTER_BUTTON;
        self.viewFitler.hidden = YES;
        
        self.currentFunction = paymentParking;
        [self.buttonUtilities setSelected:NO];
        [self.buttonParking setSelected:YES];
        [self.buttonExpress setSelected:NO];
        
        if([[parkingDataManager allData] count] == 0){
            [self sendGetParkingsRequest];
        }
        else{
            [self sendGetParkingsRequestWithPage:1 andPageSize:[[parkingDataManager allData] count]];
            [parkingDataManager clear];
        }
    }
}

- (IBAction)getExpress:(id)sender
{
    if(self.currentFunction != paymentExpress){
        self.tableTopMargin.constant = TABLE_TOP_WITHOUT_FILTER_BUTTON;
        self.viewFitler.hidden = YES;
        
        self.currentFunction = paymentExpress;
        [self.buttonUtilities setSelected:NO];
        [self.buttonParking setSelected:NO];
        [self.buttonExpress setSelected:YES];
        
        if([[expressDataManager allData] count] == 0){
            [self sendGetExpressRequest];
        }
        else{
            [self sendGetExpressRequestWithPage:1 andPageSize:[[expressDataManager allData] count]];
            [expressDataManager clear];
        }
    }
}

/*
- (IBAction)initial:(id)sender
{
    self.communitiesView.selectItemImageName = @"common_interest_bg_img";
    self.communitiesView.unselectItemImageName = @"circum_merchant_mian_bg";
    [self.communitiesView reloadData];
}
*/
- (IBAction)getMore:(id)sender
{
    UIButton *button = (UIButton *)sender;
    if(self.communitiesView.isFolded){
        [self.communitiesView unfoldView];
        [button setTitle:GET_MORE_COMMUNITY_BUTTON_UNFOLD_TITLE forState:UIControlStateNormal];
        [button setSelected:YES];
    }
    else{
        [self.communitiesView foldView];
        [button setTitle:GET_MORE_COMMUNITY_BUTTON_FOLD_TITLE forState:UIControlStateNormal];
        [button setSelected:NO];
    }
}

- (IBAction)filterUtilities:(id)sender
{
    [self showSelectionTable];
}

#pragma mark - Cell Button Actions
- (IBAction)getUtilitiesDetail:(id)sender
{
    UIButton *button = (UIButton *)sender;
    UITableViewCell *cell = [CommonHelper getParentCell:button];
    currentSelectIndex = [self.tableInformations indexPathForCell:cell].section;
    
    UtilitiesParameter *param = filterType == utilitiesAll ? [[utilitiesDataManager allData] objectAtIndex:currentSelectIndex] : filterType == utilitiesFilterPayed ? [utilitiesPayed objectAtIndex:currentSelectIndex] : [utilitiesUnpayed objectAtIndex:currentSelectIndex];
    if(param.status == UtilitiesPay){
        [self performSegueWithIdentifier:PAY_UTILITIES_SEGUE_IDENTIFIER sender:nil];
    }
    else{
        [self performSegueWithIdentifier:UNPAY_UTILITIES_SEGUE_IDENTIFIER sender:nil];
    }
}

- (IBAction)getParkingDetail:(id)sender
{
    UIButton *button = (UIButton *)sender;
    UITableViewCell *cell = [CommonHelper getParentCell:button];
    currentSelectIndex = [self.tableInformations indexPathForCell:cell].section;
    
    [self performSegueWithIdentifier:PARKING_SEGUE_IDENTIFIER sender:nil];

}

#pragma mark - Private Methods

- (void)sendGetUtilitiesRequest
{
    [self sendGetUtilitiesRequestWithPage:[utilitiesDataManager getNextLoadPage] andPageSize:DEFAULT_PAGE_SIZE];
}

- (void)sendGetParkingsRequest
{
    [self sendGetParkingsRequestWithPage:[parkingDataManager getNextLoadPage] andPageSize:DEFAULT_PAGE_SIZE];
}

- (void)sendGetExpressRequest
{
    [self sendGetExpressRequestWithPage:[expressDataManager getNextLoadPage] andPageSize:DEFAULT_PAGE_SIZE];
}

- (void)sendGetUtilitiesRequestWithPage:(int)page andPageSize:(int)pageSize
{
    currentUtilitiesResponse = nil;
    [utilitiesPayed removeAllObjects];
    [utilitiesUnpayed removeAllObjects];
    
    GetUtilitiesRequestParameter *request = [[GetUtilitiesRequestParameter alloc] init];
    request.communityId = [UserInformation instance].currentCommunity.communityId;
    request.userId = [UserInformation instance].userId;
    request.password = [UserInformation instance].password;
    request.page = page;
    request.pageSize = pageSize;
    
    [[CommunicationManager instance] getUtilities:request withDelegate:self];
    [[CommonUtilities instance] showNetworkConnecting:self];
}

- (void)sendGetParkingsRequestWithPage:(int)page andPageSize:(int)pageSize
{
    currentParkingResponse = nil;
    
    GetParkingRequestParameter *request = [[GetParkingRequestParameter alloc] init];
    request.communityId = [UserInformation instance].currentCommunity.communityId;
    request.userId = [UserInformation instance].userId;
    request.password = [UserInformation instance].password;
    request.page = page;
    request.pageSize = pageSize;
    
    [[CommunicationManager instance] getParking:request withDelegate:self];
    [[CommonUtilities instance] showNetworkConnecting:self];
}

- (void)sendGetExpressRequestWithPage:(int)page andPageSize:(int)pageSize
{
    currentExpressResponse = nil;
    
    GetExpressRequestParameter *request = [[GetExpressRequestParameter alloc] init];
    request.communityId = [UserInformation instance].currentCommunity.communityId;
    request.userId = [UserInformation instance].userId;
    request.password = [UserInformation instance].password;
    request.page = page;
    request.pageSize = pageSize;
    
    [[CommunicationManager instance] getExpress:request withDelegate:self];
    [[CommonUtilities instance] showNetworkConnecting:self];
}

- (void)constructSelectionTable
{
    tableOptions = [[UITableView alloc] initWithFrame:CGRectMake(10, 0, 300, 0)];
    [tableOptions registerClass:[OptionCell class] forCellReuseIdentifier:OPTION_REUSE_IDENTIFIER];
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
    
    float totalHeight = tableOptions.contentSize.height;
    float maxHeight = self.view.bounds.size.height - 2 * MIN_SELECTION_MARGIN;
    
    CGRect newFrame = tableOptions.frame;
    newFrame.size.height = MIN(totalHeight, maxHeight);
    tableOptions.frame = newFrame;
    tableOptions.center = self.view.center;
}

#pragma mark - Data table Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if(tableView == tableOptions){
        return 1;
    }
    else{
        switch (self.currentFunction) {
            case paymentUtilities:
                if(filterType == utilitiesFilterPayed){
                    return [utilitiesPayed count];
                }
                else if(filterType == utilitiesFilterUnpayed){
                    return [utilitiesUnpayed count];
                }
                else{
                    return [[utilitiesDataManager allData] count];
                }
            case paymentParking:
                return [[parkingDataManager allData] count];
            case paymentExpress:
                return [[expressDataManager allData] count];
            }
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(tableView == tableOptions){
        return 3;
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
        switch (self.currentFunction) {
            case paymentUtilities:
                return 58;
            case paymentParking:
                return 72;
            case paymentExpress:
                return 58;
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return tableView == tableOptions ? 44 : 10;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if(tableView == tableOptions) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableOptions.bounds.size.width, 44)];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, view.frame.size.width, 44)];
        NSString *titleText = @"    请选择状态";
       
        label.text = titleText;
        view.backgroundColor = [UIColor blackColor];
        label.textColor = [UIColor whiteColor];
        label.backgroundColor = [UIColor clearColor];
        [view addSubview:label];
    
        return view;
    }
    else{
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = [UIColor clearColor];
        return view;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView == tableOptions){
        OptionCell *cell = [tableView dequeueReusableCellWithIdentifier:OPTION_REUSE_IDENTIFIER forIndexPath:indexPath];
        [cell setOptionString:[filterDescriptions objectAtIndex:indexPath.row]];
        return cell;
    }
    else{
        switch (self.currentFunction) {
            case paymentUtilities:{
                PaymentUtilitiesCell *cell = [tableView dequeueReusableCellWithIdentifier:UTILITIES_REUSE_IDENTIFIER forIndexPath:indexPath];
                UtilitiesParameter *utility = [[utilitiesDataManager allData] objectAtIndex:indexPath.section];
                
                if(filterType == utilitiesFilterPayed){
                    utility = [utilitiesPayed objectAtIndex:indexPath.section];
                }
                else if(filterType == utilitiesFilterUnpayed){
                    utility = [utilitiesUnpayed objectAtIndex:indexPath.section];
                }
                
                cell.labelMoney.text = utility.totalFee;
                cell.labelOwnerName.text = utility.name;
                
                cell.labelRoomNo.text = [NSString stringWithFormat:ROOM_NO_FORMAT,utility.buildNo,utility.floorNo,utility.roomNo];
                cell.labelTime.text = utility.time;
                
                if(utility.status == UtilitiesNotPay){
                    cell.buttonPay.hidden = NO;
                    cell.labelAlreadyPayTips.hidden = YES;
                    cell.imageAlreadyPay.hidden = YES;
                    cell.imageUnpay.hidden = NO;
                    
                }
                else{
                    cell.buttonPay.hidden = YES;
                    cell.labelAlreadyPayTips.hidden = NO;
                    cell.imageAlreadyPay.hidden = NO;
                    cell.imageUnpay.hidden = YES;
                }
                
                return cell;
            }
            case paymentParking:{
                PaymentParkingCell *cell = [tableView dequeueReusableCellWithIdentifier:PARKING_REUSE_IDENTIFIER forIndexPath:indexPath];
                ParkingParameter *parking =[[parkingDataManager allData] objectAtIndex:indexPath.section];
                cell.labelCardNo.text = parking.cardNo;
                cell.labelCarNo.text = parking.carNo;
                cell.labelExpirationTime.text = parking.expirationTime;
                cell.labelMoney.text = [NSString stringWithFormat:@"[%.2f元]",parking.price];
                cell.labelOwnerName.text = parking.name;
                cell.labelRoomNo.text = [NSString stringWithFormat:ROOM_NO_FORMAT,parking.buildNo,parking.floorNo,parking.roomNo];
                if([NSDate isExpiration:parking.expirationTime]){
                    cell.imageUnpay.hidden = NO;
                    cell.imageAlreadyPay.hidden = YES;
                }
                else{
                    cell.imageUnpay.hidden = YES;
                    cell.imageAlreadyPay.hidden = NO;
                }
                
                return cell;
            }
            case paymentExpress:{
                ExpressParameter *express = [[expressDataManager allData] objectAtIndex:indexPath.section];
                if(express.status == ExpressReceived){
                    PaymentReceivedExpressCell *cell = [tableView dequeueReusableCellWithIdentifier:EXPRESS_RECEIVED_REUSE_IDENTIFIER forIndexPath:indexPath];
                    
                    cell.labelArriveTime.text = express.arrivedTime;
                    cell.labelExpressName.text = express.expressCrop;
                    
                    NSString *plainText = [NSString stringWithFormat:@"您有[%d]个快递已在[%@]领取",express.quantity,express.receivedTime];
                    NSMutableAttributedString *styledText = [[NSMutableAttributedString alloc] initWithString:plainText];
                    NSDictionary *attributes = @{NSForegroundColorAttributeName : [UIColor orangeColor]};
                    NSRange range = [plainText rangeOfString:[NSString stringWithFormat:@"[%d]",express.quantity]];
                    [styledText setAttributes:attributes range:range];
                    range = [plainText rangeOfString:[NSString stringWithFormat:@"[%@]",express.receivedTime]];
                    [styledText addAttributes:attributes range:range];
                    cell.labelInformation.attributedText = styledText;
                    
                    cell.labelOwnerName.text = express.name;
                    cell.labelRoomNo.text = [NSString stringWithFormat:ROOM_NO_FORMAT,express.buildNo,express.floorNo,express.roomNo];
                    
                    return cell;

                }
                else{
                    PaymentUnreceivedExpressCell *cell = [tableView dequeueReusableCellWithIdentifier:EXPRESS_UNRECEIVED_REUSE_IDENTIFIER forIndexPath:indexPath];
                    
                    cell.labelArriveTime.text = express.arrivedTime;
                    cell.labelExpressName.text = express.expressCrop;
                    
                    NSString *plainText = [NSString stringWithFormat:@"您有[%d]个快递未领取",express.quantity];
                    NSMutableAttributedString *styledText = [[NSMutableAttributedString alloc] initWithString:plainText];
                    NSDictionary *attributes = @{NSForegroundColorAttributeName : [UIColor orangeColor]};
                    NSRange range = [plainText rangeOfString:[NSString stringWithFormat:@"[%d]",express.quantity]];
                    [styledText setAttributes:attributes range:range];
                    cell.labelInformation.attributedText = styledText;
                    
                    cell.labelOwnerName.text = express.name;
                    cell.labelRoomNo.text = [NSString stringWithFormat:ROOM_NO_FORMAT,express.buildNo,express.floorNo,express.roomNo];
                    
                    return cell;
                }
            }
        }
    }
}


- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath
{
    return tableView == tableOptions ? YES : NO;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.buttonFilter setTitle:[filterDescriptions objectAtIndex:indexPath.row] forState:UIControlStateNormal];
    filterType = (UtilitiesFilterType)indexPath.row;
    [self.tableInformations reloadData];
    
    tableOptions.hidden = YES;
    self.viewMask.hidden = YES;
}

#pragma mark - FoldableView Delegate

- (int)numberOfItemInView
{
    return [[UserInformation instance].communities count];
}

- (NSString *)foldableView:(FoldableView *)foldableView titleAtIndex:(int)index
{
    return [[UserInformation instance] getCommunity:index].communityName;
}

- (void)foldableView:(FoldableView *)foldableView didSelectAtIndex:(int)index
{
    [UserInformation instance].currentCommunityIndex = index;
    
    switch (self.currentFunction) {
        case paymentUtilities:
            [utilitiesDataManager clear];
            [self sendGetUtilitiesRequest];
            break;
        case paymentParking:
            [parkingDataManager clear];
            [self sendGetParkingsRequest];
            break;
        case paymentExpress:
            [expressDataManager clear];
            [self sendGetExpressRequest];
            break;
    }
}

#pragma mark - Communication Delegate

- (void)ProcessServerResponse:(id)response
{
    switch (self.currentFunction) {
        case paymentUtilities:
            currentUtilitiesResponse = response;
            if([currentUtilitiesResponse.utilitiesBills count] == 0){
                [self showErrorMessage:@"当前暂无水电气物业费信息"];
            }
            else{
                [utilitiesDataManager populateData:currentUtilitiesResponse.utilitiesBills];
                utilitiesPayed = [NSMutableArray array];
                utilitiesUnpayed = [NSMutableArray array];
                for (UtilitiesParameter *param in [utilitiesDataManager allData]) {
                    if(param.status == UtilitiesNotPay){
                        [utilitiesUnpayed addObject:param];
                    }
                    else{
                        [utilitiesPayed addObject:param];
                    }
                }
            }
            break;
        case paymentParking:
            currentParkingResponse = response;
            if([currentParkingResponse.parkingBills count] == 0){
                [self showErrorMessage:@"当前暂无停车费信息"];
            }
            else{
                
                [parkingDataManager populateData:currentParkingResponse.parkingBills];
            }
            break;
        case paymentExpress:
            currentExpressResponse = response;
            if([currentExpressResponse.expresses count] == 0){
                [self showErrorMessage:@"当前暂无快递信息"];
            }
            else{
                [expressDataManager populateData:currentExpressResponse.expresses];
            }
            break;
    }
    
    [self.tableInformations reloadData];
    CGFloat height = MAX(self.tableInformations.contentSize.height, self.tableInformations.frame.size.height);
    if(refreshHeaderView == nil){
        EGORefreshTableHeaderView *view =[[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0.0f, height, self.tableInformations.bounds.size.width, self.tableInformations.bounds.size.height)];
        view.delegate = self;
        [self.tableInformations addSubview:view];
        refreshHeaderView = view;
    }
    else{
        CGRect newFrame = refreshHeaderView.frame;
        newFrame.origin.y = height;
        refreshHeaderView.frame = newFrame;
        [refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:self.tableInformations];
        isReloading = NO;
    }

    [[CommonUtilities instance] hideNetworkConnecting];
}

- (void)ProcessServerFail:(ServerFailInformation *)failInfo
{
    [[CommonUtilities instance] hideNetworkConnecting];
    [self.tableInformations reloadData];
    [refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:self.tableInformations];
    isReloading = NO;
    NSLog(@"%@",failInfo.message);
    [self showErrorMessage:failInfo.message];
}

- (void)ProcessCommunicationError:(NSError *)error
{
    [[CommonUtilities instance] hideNetworkConnecting];
    [self.tableInformations reloadData];
    [refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:self.tableInformations];
    isReloading = NO;
    NSLog(@"%@",error.localizedDescription);
    [self showErrorMessage:error.localizedDescription];
}


#pragma mark - EGORefreshTableHeaderDelegate Methods
-(void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView*)view{
    isReloading = YES;
    switch (currentFunction) {
        case paymentUtilities:
            [self sendGetUtilitiesRequest];
            break;
        case paymentParking:
            [self sendGetParkingsRequest];
            break;
        case paymentExpress:
            [self sendGetExpressRequest];
            break;
    }
}

-(BOOL)egoRefreshTableHeaderDataSourceIsLoading:(EGORefreshTableHeaderView*)view{
    return isReloading;
}

#pragma mark - UIScrollViewDelegate Methods

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [refreshHeaderView egoRefreshScrollViewDidScroll:scrollView];
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    [refreshHeaderView egoRefreshScrollViewDidEndDragging:scrollView];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    if([segue.destinationViewController isKindOfClass:[UtilitiesDetailViewController class]]){
        UtilitiesDetailViewController *destination = (UtilitiesDetailViewController *)segue.destinationViewController;
        UtilitiesParameter *param = [[utilitiesDataManager allData] objectAtIndex:currentSelectIndex];
        destination.utilities = param;
    }
    if([segue.destinationViewController isKindOfClass:[UtilitiesUnpayDetailViewController class]]){
        UtilitiesUnpayDetailViewController *destination = (UtilitiesUnpayDetailViewController *)segue.destinationViewController;
        UtilitiesParameter *param = [[utilitiesDataManager allData] objectAtIndex:currentSelectIndex];
        destination.utilities = param;
        destination.centerController = self;
    }
    if([segue.destinationViewController isKindOfClass:[ParkingDetailViewController class]]){
        ParkingDetailViewController *destination = (ParkingDetailViewController *)segue.destinationViewController;
        ParkingParameter *param = [[parkingDataManager allData] objectAtIndex:currentSelectIndex];
        destination.parking = param;
        destination.centerController = self;
    }
}


@end

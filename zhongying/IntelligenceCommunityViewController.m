//
//  IntelligenceCommunityViewController.m
//  zhongying
//
//  Created by lik on 14-3-22.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import "IntelligenceCommunityViewController.h"
#import "CommonUtilities.h"
#import "CommunicationManager.h"
#import "UserInformation.h"
#import "UtilitiesParameter.h"
#import "ParkingParameter.h"
#import "ExpressParameter.h"
#import "UtilitiesCell.h"
#import "ParkingCell.h"
#import "ExpressCell.h"

#define UTILITIES_HEAD_REUSE_IDENTIFIER         @"UtilitiesHead"
#define UTILITIES_CONTENT_REUSE_IDENTIFIER      @"UtilitiesContent"
#define PARKING_HEAD_REUSE_IDENTIFIER           @"ParkingHead"
#define PARKING_CONTENT_REUSE_IDENTIFIER        @"ParkingContent"
#define EXPRESS_HEAD_REUSE_IDENTIFIER           @"ExpressHead"
#define EXPRESS_CONTENT_REUSE_IDENTIFIER        @"ExpressContent"
#define UTILITIES_TITLE_FORMAT                  @"水电气物业费查询（%@）"
#define PARKING_TITLE_FORMAT                    @"停车费查询（%@）"
#define EXPRESS_TITLE_FORMAT                    @"快递查询（%@）"

@interface IntelligenceCommunityViewController ()

- (void)sendGetUtilitiesRequest;
- (void)sendGetParkingsRequest;
- (void)sendGetExpressRequest;

@end

@implementation IntelligenceCommunityViewController

@synthesize currentFunction, buttonUtilities, butonParking, buttonExpress, labelTitle, tableInformations;

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
    //currentCommunity = [[UserInformation instance].communities objectAtIndex:[UserInformation instance].currentCommunityIndex];
    self.tableInformations.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    switch (self.currentFunction) {
        case communityUtilities:
            [self sendGetUtilitiesRequest];
            break;
        case communityParking:
            [self sendGetParkingsRequest];
            break;
        case communityExpress:
            [self sendGetExpressRequest];
            break;
    }
}

#pragma mark - Private Methods
- (void)sendGetUtilitiesRequest
{
    //[self.buttonUtilities setHighlighted:YES];
    //[self.butonParking setHighlighted:NO];
    //[self.buttonExpress setHighlighted:NO];
    
    self.labelTitle.text = [NSString stringWithFormat:UTILITIES_TITLE_FORMAT, currentCommunity.communityName];
    
    [self.tableInformations reloadData];
    currentUtilitiesResponse = nil;
    
    GetUtilitiesRequestParameter *request = [[GetUtilitiesRequestParameter alloc] init];
    request.communityId = currentCommunity.communityId;
    request.userId = [UserInformation instance].userId;
    request.password = [UserInformation instance].password;
    
    [[CommunicationManager instance] getUtilities:request withDelegate:self];
    [[CommonUtilities instance] showNetworkConnecting:self];
}

- (void)sendGetParkingsRequest
{
    //[self.buttonUtilities setHighlighted:NO];
    //[self.butonParking setHighlighted:YES];
    //[self.buttonExpress setHighlighted:NO];
    
    self.labelTitle.text = [NSString stringWithFormat:PARKING_TITLE_FORMAT, currentCommunity.communityName];
    
    [self.tableInformations reloadData];
    currentParkingResponse = nil;
    
    GetParkingRequestParameter *request = [[GetParkingRequestParameter alloc] init];
    request.communityId = currentCommunity.communityId;
    request.userId = [UserInformation instance].userId;
    request.password = [UserInformation instance].password;
    
    [[CommunicationManager instance] getParking:request withDelegate:self];
    [[CommonUtilities instance] showNetworkConnecting:self];
}

- (void)sendGetExpressRequest
{
    //[self.buttonUtilities setHighlighted:NO];
    //[self.butonParking setHighlighted:NO];
    //[self.buttonExpress setHighlighted:YES];
    
    self.labelTitle.text = [NSString stringWithFormat:EXPRESS_TITLE_FORMAT, currentCommunity.communityName];
    
    [self.tableInformations reloadData];
    currentExpressResponse = nil;
    
    GetExpressRequestParameter *request = [[GetExpressRequestParameter alloc] init];
    request.communityId = currentCommunity.communityId;
    request.userId = [UserInformation instance].userId;
    request.password = [UserInformation instance].password;
    
    [[CommunicationManager instance] getExpress:request withDelegate:self];
    [[CommonUtilities instance] showNetworkConnecting:self];
}

#pragma mark - Data table Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (self.currentFunction) {
        case communityUtilities:
            if(currentUtilitiesResponse == nil){
                return 1;
            }
            else{
                return [currentUtilitiesResponse.utilitiesBills count] + 1;
            }
        case communityParking:
            if(currentParkingResponse == nil){
                return 1;
            }
            else{
                return [currentParkingResponse.parkingBills count] + 1;
            }
        case communityExpress:
            if(currentExpressResponse == nil){
                return 1;
            }
            else{
                return [currentExpressResponse.expresses count] + 1;
            }
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (self.currentFunction) {
        case communityUtilities:{
            if(indexPath.row == 0){
                UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:UTILITIES_HEAD_REUSE_IDENTIFIER forIndexPath:indexPath];
                return cell;
            }
            else{
                UtilitiesCell *cell = [tableView dequeueReusableCellWithIdentifier:UTILITIES_CONTENT_REUSE_IDENTIFIER forIndexPath:indexPath];
                UtilitiesParameter *utility = [currentUtilitiesResponse.utilitiesBills objectAtIndex:indexPath.row - 1];
                cell.labelName.text = utility.name;
                cell.labelRoomNo.text = [NSString stringWithFormat:@"%@-%@-%@",utility.buildNo,utility.floorNo,utility.roomNo];
                cell.labelTime.text = utility.time;
                cell.labelFee.text = [NSString stringWithFormat:@"%.2f",utility.totalFee];
                
                return cell;
            }
        }
            break;
        case communityParking:{
            if(indexPath.row == 0){
                UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:PARKING_HEAD_REUSE_IDENTIFIER forIndexPath:indexPath];
                return cell;
            }
            else{
                ParkingCell *cell = [tableView dequeueReusableCellWithIdentifier:PARKING_CONTENT_REUSE_IDENTIFIER forIndexPath:indexPath];
                ParkingParameter *parking =[currentParkingResponse.parkingBills objectAtIndex:indexPath.row - 1];
                cell.labelName.text = parking.name;
                cell.labelRoomNo.text = [NSString stringWithFormat:@"%@-%@-%@",parking.buildNo,parking.floorNo,parking.roomNo];
                cell.labelCarNo.text = parking.carNo;
                cell.labelCardNo.text = parking.cardNo;
                cell.labelExpiration.text = parking.expirationTime;
                cell.labelFee.text = [NSString stringWithFormat:@"%.2f",parking.price];
                
                return cell;
            }
        }
            break;
        case communityExpress:{
            if(indexPath.row == 0){
                UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:EXPRESS_HEAD_REUSE_IDENTIFIER forIndexPath:indexPath];
                return cell;
            }
            else{
                ExpressCell *cell = [tableView dequeueReusableCellWithIdentifier:EXPRESS_CONTENT_REUSE_IDENTIFIER forIndexPath:indexPath];
                ExpressParameter *express = [currentExpressResponse.expresses objectAtIndex:indexPath.row - 1];
                cell.labelName.text = express.name;
                cell.labelRoomNo.text = [NSString stringWithFormat:@"%@-%@-%@",express.buildNo,express.floorNo,express.roomNo];
                cell.labelQuantity.text = [NSString stringWithFormat:@"%d",express.quantity];
                cell.labelExpressCorp.text = express.expressCrop;
                cell.labelReceivedTime.text = express.receivedTime;
                return cell;
            }
        }
            break;
    }
}

#pragma mark - Button Actions

- (IBAction)getUtilities:(id)sender
{
    currentFunction = communityUtilities;
    [self sendGetUtilitiesRequest];
}

- (IBAction)getParking:(id)sender
{
    currentFunction = communityParking;
    [self sendGetParkingsRequest];
}

- (IBAction)getExpress:(id)sender
{
    currentFunction = communityExpress;
    [self sendGetExpressRequest];
}

#pragma mark - Communication Delegate

- (void)ProcessServerResponse:(id)response
{
    switch (self.currentFunction) {
        case communityUtilities:
            currentUtilitiesResponse = response;
            break;
        case communityParking:
            currentParkingResponse = response;
            break;
        case communityExpress:
            currentExpressResponse = response;
            break;
    }
    
    [self.tableInformations reloadData];
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

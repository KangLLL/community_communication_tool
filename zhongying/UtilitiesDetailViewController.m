//
//  UtilitiesDetailViewController.m
//  zhongying
//
//  Created by lik on 14-4-1.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import "UtilitiesDetailViewController.h"
#import "UserInformation.h"
#import "CommunicationManager.h"
#import "GetUtilitiesDetailRequestParameter.h"
#import "UtilitiesDetailResponseParameter.h"
#import "CommonUtilities.h"
#import "CommonConsts.h"

@interface UtilitiesDetailViewController ()

@end

@implementation UtilitiesDetailViewController

@synthesize labelCommunityName, labelElectricityFee, labelGasFee, labelOwnerName, labelPayerName, labelPayTime, labelPropertyFee, labelRoomNo, labelShareFee, labelTotalFee, labelValidTime, labelWaterFee, utilities;

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
    // Do any additional setup after loading the view.
}


- (void)viewDidAppear:(BOOL)animated
{
    GetUtilitiesDetailRequestParameter *request = [[GetUtilitiesDetailRequestParameter alloc] init];
    request.billId = self.utilities.billId;
    request.userId = [UserInformation instance].userId;
    request.password = [UserInformation instance].password;
    
    [[CommunicationManager instance] getUtilitiesDetail:request withDelegate:self];
    [[CommonUtilities instance] showNetworkConnecting:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Communication Delegate
- (void)ProcessServerResponse:(id)response
{
    UtilitiesDetailResponseParameter *param = response;
    self.labelCommunityName.text = [UserInformation instance].currentCommunity.communityName;
    self.labelElectricityFee.text = param.electricityFee;
    self.labelGasFee.text = param.gasFee;
    self.labelWaterFee.text = param.waterFee;
    self.labelOwnerName.text = self.utilities.name;
    self.labelPayerName.text = param.payerName;
    self.labelPayTime.text = param.payTime;
    self.labelPropertyFee.text = param.propertyFee;
    self.labelShareFee.text = param.shareFee;
    self.labelTotalFee.text = self.utilities.totalFee;
    self.labelValidTime.text = self.utilities.time;
    self.labelRoomNo.text = [NSString stringWithFormat:ROOM_NO_FORMAT,self.utilities.buildNo,self.utilities.floorNo,self.utilities.roomNo];
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

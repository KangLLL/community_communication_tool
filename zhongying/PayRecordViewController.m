//
//  PayRecordViewController.m
//  zhongying
//
//  Created by lk on 14-4-15.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import "PayRecordViewController.h"
#import "CommonUtilities.h"
#import "CommonConsts.h"
#import "UserInformation.h"
#import "GetMyUtilitiesRequestParameter.h"
#import "GetMyParkingRequestParameter.h"
#import "PropertyRecordCell.h"
#import "ParkingRecordCell.h"
#import "MyUtilitiesParameter.h"
#import "MyParkingParameter.h"

#define PROPERTY_CELL_REUSE_IDENTIFIER      @"Property"
#define PARKING_CELL_REUSE_IDENTIFIER       @"Parking"

@interface PayRecordViewController ()

- (void)updateUI;
- (void)sendGetPropertyRequest;
- (void)sendGetParkingRequest;

- (void)sendGetPropertyRequestWithPage:(int)page andPageSize:(int)pageSize;
- (void)sendGetParkingRequestWithPage:(int)page andPageSize:(int)pageSize;

@end

@implementation PayRecordViewController

@synthesize buttonParking, buttonProperty, viewParkingHead, viewPropertyHead;

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
    
    currentType = recordProperty;
    self.tableInformation.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self updateUI];
    
    utilitiesDataManager = [[PageDataManager alloc] initWithPageSize:DEFAULT_PAGE_SIZE];
    parkingDataManager = [[PageDataManager alloc] initWithPageSize:DEFAULT_PAGE_SIZE];
    // Do any additional setup after loading the view.
}

- (void)viewDidAppear:(BOOL)animated
{
    if(currentType == recordProperty){
        if([[utilitiesDataManager allData] count] == 0){
            [self sendGetPropertyRequest];
        }
        else{
            [self sendGetPropertyRequestWithPage:1 andPageSize:[[utilitiesDataManager allData] count]];
            [utilitiesDataManager clear];
        }
    }
    else{
        if([[parkingDataManager allData] count] == 0){
            [self sendGetParkingRequest];
        }
        else{
            [self sendGetParkingRequestWithPage:1 andPageSize:[[parkingDataManager allData] count]];
            [parkingDataManager clear];
        }

    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Data table Delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(currentType == recordProperty){
        return [[utilitiesDataManager allData] count];
    }
    else if(currentType == recordParking){
        return [[parkingDataManager allData] count];
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(currentType == recordProperty){
        return 35;
    }
    else{
        return 45;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    int index = indexPath.section;
    if(currentType == recordProperty){
        MyUtilitiesParameter *param = [[utilitiesDataManager allData] objectAtIndex:index];
        PropertyRecordCell *cell = [tableView dequeueReusableCellWithIdentifier:PROPERTY_CELL_REUSE_IDENTIFIER forIndexPath:indexPath];
        cell.labelMoney.text = [NSString stringWithFormat:@"%.2f",param.totalFee];
        cell.labelTime.text = param.time;
        cell.labelName.text = [NSString stringWithFormat:@"%@\r%@-%@-%@",param.payerName, param.buildNo, param.floorNo, param.roomNo];
        cell.labelStatus.text = @"缴费成功！";
        return cell;
    }
    else{
        MyParkingParameter *param = [[parkingDataManager allData] objectAtIndex:index];
        ParkingRecordCell *cell = [tableView dequeueReusableCellWithIdentifier:PARKING_CELL_REUSE_IDENTIFIER forIndexPath:indexPath];
        cell.labelCarNo.text = param.carNo;
        cell.labelExpirationTime.text = param.expirationTime;
        cell.labelMoney.text = [NSString stringWithFormat:@"%.2f",param.totalFee];
        cell.labelName.text = [NSString stringWithFormat:@"%@\r%@-%@-%@",param.payerName, param.buildNo, param.floorNo, param.roomNo];
        cell.labelPayTime.text = param.time;
        cell.labelStatus.text = @"缴费成功！";
        return cell;
    }
}

#pragma mark - Communication Delegate

- (void)ProcessServerResponse:(id)response
{
    if(currentType == recordProperty){
        propertyResponse = response;
        [utilitiesDataManager populateData:propertyResponse.myUtilities];
    }
    else{
        parkingResponse = response;
        [parkingDataManager populateData:parkingResponse.myParkings];
    }
    
    [self.tableInformation reloadData];
    CGFloat height = MAX(self.tableInformation.contentSize.height, self.tableInformation.frame.size.height);
    if(refreshHeaderView == nil){
        EGORefreshTableHeaderView *view =[[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0.0f, height, self.tableInformation.bounds.size.width, self.tableInformation.bounds.size.height)];
        view.delegate = self;
        [self.tableInformation addSubview:view];
        refreshHeaderView = view;
    }
    else{
        CGRect newFrame = refreshHeaderView.frame;
        newFrame.origin.y = height;
        refreshHeaderView.frame = newFrame;
        [refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:self.tableInformation];
        isReloading = NO;
    }
    [[CommonUtilities instance] hideNetworkConnecting];
}

- (void)ProcessServerFail:(ServerFailInformation *)failInfo
{
    [[CommonUtilities instance] hideNetworkConnecting];
    [refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:self.tableInformation];
    isReloading = NO;
    NSLog(@"%@",failInfo.message);
    [self showErrorMessage:failInfo.message];
}

- (void)ProcessCommunicationError:(NSError *)error
{
    [[CommonUtilities instance] hideNetworkConnecting];
    [refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:self.tableInformation];
    isReloading = NO;
    NSLog(@"%@",error.localizedDescription);
    [self showErrorMessage:error.localizedDescription];
}


#pragma mark - Button Actions

- (IBAction)getParking:(id)sender
{
    if(currentType != recordParking){
        currentType = recordParking;
        [self updateUI];
        [parkingDataManager clear];
        [self sendGetParkingRequest];
    }
}

- (IBAction)getProperty:(id)sender
{
    if(currentType != recordProperty){
        currentType = recordProperty;
        [self updateUI];
        [utilitiesDataManager clear];
        [self sendGetPropertyRequest];
    }
}

#pragma mark - Private Methods

- (void)updateUI
{
    if(currentType == recordProperty){
        [self.buttonProperty setSelected:YES];
        [self.buttonParking setSelected:NO];
        
        self.viewPropertyHead.hidden = NO;
        self.viewParkingHead.hidden = YES;
    }
    else{
        [self.buttonProperty setSelected:NO];
        [self.buttonParking setSelected:YES];
        
        self.viewPropertyHead.hidden = YES;
        self.viewParkingHead.hidden = NO;
    }
}

- (void)sendGetPropertyRequest
{
    [self sendGetPropertyRequestWithPage:[utilitiesDataManager getNextLoadPage] andPageSize:DEFAULT_PAGE_SIZE];
}

- (void)sendGetParkingRequest
{
    [self sendGetParkingRequestWithPage:[parkingDataManager getNextLoadPage] andPageSize:DEFAULT_PAGE_SIZE];
}

- (void)sendGetPropertyRequestWithPage:(int)page andPageSize:(int)pageSize
{
    propertyResponse = nil;
    
    GetMyUtilitiesRequestParameter *request = [[GetMyUtilitiesRequestParameter alloc] init];
    request.userId = [UserInformation instance].userId;
    request.password = [UserInformation instance].password;
    request.page = page;
    request.pageSize = pageSize;
    [[CommunicationManager instance] getMyUtilities:request withDelegate:self];
    [[CommonUtilities instance] showNetworkConnecting:self];
}

- (void)sendGetParkingRequestWithPage:(int)page andPageSize:(int)pageSize
{
    parkingResponse = nil;
    
    GetMyParkingRequestParameter *request = [[GetMyParkingRequestParameter alloc] init];
    request.userId = [UserInformation instance].userId;
    request.password = [UserInformation instance].password;
    request.page = page;
    request.pageSize = pageSize;
    [[CommunicationManager instance] getMyParkings:request withDelegate:self];
    [[CommonUtilities instance] showNetworkConnecting:self];
}

#pragma mark - EGORefreshTableHeaderDelegate Methods
-(void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView*)view{
    isReloading = YES;
    if(currentType == recordProperty){
        [self sendGetPropertyRequest];
    }
    else if(currentType == recordParking){
        [self sendGetParkingRequest];
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

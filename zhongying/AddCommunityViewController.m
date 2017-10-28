//
//  AddCommunityViewController.m
//  zhongying
//
//  Created by lik on 14-3-22.
//  Copyright (c) 2014年 lik. All rights reserved.
//

#import "AddCommunityViewController.h"
#import "CommonConsts.h"
#import "CommonUtilities.h"
#import "CommonHelper.h"
#import "CommunicationManager.h"
#import "UserInformation.h"
#import "OptionCell.h"
#import "DistrictInformation.h"
#import "RegionInformation.h"
#import "CommunityInfoParameter.h"
#import "GetCommunityRequestParameter.h"
#import "GetRoomRequestParameter.h"
#import "BindCommunityRequestParameter.h"


#define OPTION_CELL_REUSE_IDENTIFIER    @"Option"

@interface AddCommunityViewController ()

- (void)sendBindCommunityRequest;
- (void)constructSelectionTable;
- (void)showSelectionTable;

@end

@implementation AddCommunityViewController

@synthesize viewMask, textBuild, textCity, textCommunity, textDisctrict, textFloor, textOwnerName, textProvince, textRoom, constraint;

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
    [self registerTextField:self.textOwnerName];
    initialConst = self.constraint.constant;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Text Field Delegate

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if(textField == self.textProvince){
        currentSelection = addSelectProvince;
        if(tableOptions == nil){
            [self constructSelectionTable];
        }
        [self showSelectionTable];
        return NO;
    }
    else if(textField == self.textCity){
        if(currentProvince != nil){
            currentSelection = addSelectCity;
            [self showSelectionTable];
        }
        else{
            [self showErrorMessage:@"请先选择省份"];
        }
        return NO;
    }
    else if(textField == self.textDisctrict){
        if(currentCity != nil){
            currentSelection = addSelectDistrict;
            [self showSelectionTable];
        }
        else{
            [self showErrorMessage:@"请先选择市"];
        }
        return NO;
    }
    else if(textField == self.textCommunity){
        if(currentDistrict != nil){
            currentCommunityResponse = nil;
            
            currentSelection = addSelectCommunity;
            GetCommunityRequestParameter *request = [[GetCommunityRequestParameter alloc] init];
            request.userId = [UserInformation instance].userId;
            request.password = [UserInformation instance].password;
            request.provinceId = [NSString stringWithFormat:@"%d",currentProvince.regionId];
            request.cityId = [NSString stringWithFormat:@"%d",currentCity.regionId];
            request.districtId = [NSString stringWithFormat:@"%d",currentDistrict.regionId];
            [[CommunicationManager instance] getAllCommunities:request withDelegate:self];
            [[CommonUtilities instance] showNetworkConnecting:self];
        }
        else{
            [self showErrorMessage:@"请先选择区"];
        }
        return NO;
    }
    else if(textField == self.textBuild){
        if(currentCommunity != nil){
            currentRoomResponse = nil;
            
            currentSelection = addSelectBuild;
            GetRoomRequestParameter *request = [[GetRoomRequestParameter alloc] init];
            request.userId = [UserInformation instance].userId;
            request.password = [UserInformation instance].password;
            request.communityId = currentCommunity.communityId;
            [[CommunicationManager instance] getAllRooms:request withDelegate:self];
            [[CommonUtilities instance] showNetworkConnecting:self];
        }
        else{
            [self showErrorMessage:@"请先选择小区"];
        }
        return NO;
    }
    else if(textField == self.textFloor){
        if(currentBuild != nil){
            currentSelection = addSelectFloor;
            [self showSelectionTable];
        }
        else{
            [self showErrorMessage:@"请先选择栋"];
        }
        return NO;
    }
    else if(textField == self.textRoom){
        if(currentFloor != nil){
            currentSelection = addSelectRoom;
            [self showSelectionTable];
        }
        else{
            [self showErrorMessage:@"请先选择层"];
        }
        return NO;
    }
    else{
        if(currentRoom != nil){
            currentSelection = addSelectName;
            return YES;
        }
        else{
            [self showErrorMessage:@"请先选择房间"];
            return NO;
        }
    }
}

#pragma mark - Table Delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (currentSelection) {
        case addSelectProvince:
            return [[[DistrictInformation instance] provinces] count];
        case addSelectCity:
            return [[[DistrictInformation instance] getCitys:currentProvince.regionId] count];
        case addSelectDistrict:
            return [[[DistrictInformation instance] getDistricts:currentCity.regionId] count];
        case addSelectCommunity:
            return [currentCommunityResponse.communities count];
        case addSelectBuild:
            return [currentRoomResponse.buildings count];
        case addSelectFloor:
            return [currentBuild.floors count];
        case addSelectRoom:
            return [currentFloor.rooms count];
        default:
            return 0;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    OptionCell *cell = [tableView dequeueReusableCellWithIdentifier:OPTION_CELL_REUSE_IDENTIFIER forIndexPath:indexPath];
    CGRect rect = CGRectMake(20, 10, 200, 44);
    
    switch (currentSelection) {
        case addSelectProvince:{
            RegionInformation *region = [[[DistrictInformation instance] provinces] objectAtIndex:indexPath.row];
            [cell setOptionString:region.regionName withFrame:rect];
        }
            break;
        case addSelectCity:{
            RegionInformation *region = [[[DistrictInformation instance] getCitys:currentProvince.regionId] objectAtIndex:indexPath.row];
            [cell setOptionString:region.regionName withFrame:rect];
        }
            break;
        case addSelectDistrict:{
            RegionInformation *region = [[[DistrictInformation instance] getDistricts:currentCity.regionId] objectAtIndex:indexPath.row];
            [cell setOptionString:region.regionName withFrame:rect];
        }
            break;
        case addSelectCommunity:{
            CommunityInfoParameter *community = [currentCommunityResponse.communities objectAtIndex:indexPath.row];
            [cell setOptionString:community.communityName withFrame:rect];
        }
            break;
        case addSelectBuild:{
            BuildParameter *build = [currentRoomResponse.buildings objectAtIndex:indexPath.row];
            [cell setOptionString:build.buildNo withFrame:rect];
        }
            break;
        case addSelectFloor:{
            FloorParameter *floor = [currentBuild.floors objectAtIndex:indexPath.row];
            [cell setOptionString:floor.floorNo withFrame:rect];
        }
            break;
        case addSelectRoom:{
            RoomParameter *room = [currentFloor.rooms objectAtIndex:indexPath.row];
            [cell setOptionString:room.roomNo withFrame:rect];
        }
            break;
        default:
            break;
    }
    
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableOptions.bounds.size.width, 44)];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, view.frame.size.width, 44)];
    NSString *titleText = @"";
    switch (currentSelection) {
        case addSelectProvince:{
            titleText = @"    请选择地区";
        }
            break;
        case addSelectCity:{
            titleText = @"    请选择地区";
        }
            break;
        case addSelectDistrict:{
            titleText = @"    请选择地区";
        }
            break;
        case addSelectCommunity:{
            titleText = @"    请选择小区";
        }
            break;
        case addSelectBuild:{
            titleText = @"    请选择楼栋";
        }
            break;
        case addSelectFloor:{
            titleText = @"    请选择楼层";
        }
            break;
        case addSelectRoom:{
            titleText = @"    请选择房间号";
        }
            break;
        default:
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
    switch (currentSelection) {
        case addSelectProvince:{
            RegionInformation *region = [[[DistrictInformation instance] provinces] objectAtIndex:indexPath.row];
            currentProvince = region;
            self.textProvince.text = region.regionName;
            
            currentCity = nil;
            currentDistrict = nil;
            currentCommunity = nil;
            currentBuild = nil;
            currentFloor = nil;
            currentRoom = nil;
            
            self.textCity.text = @"";
            self.textDisctrict.text = @"";
            self.textCommunity.text = @"";
            self.textBuild.text = @"";
            self.textFloor.text = @"";
            self.textRoom.text = @"";
            self.textOwnerName.text = @"";
        }
            break;
        case addSelectCity:{
            RegionInformation *region = [[[DistrictInformation instance] getCitys:currentProvince.regionId] objectAtIndex:indexPath.row];
            currentCity = region;
            self.textCity.text = region.regionName;
            
            currentDistrict = nil;
            currentCommunity = nil;
            currentBuild = nil;
            currentFloor = nil;
            currentRoom = nil;
            
            self.textDisctrict.text = @"";
            self.textCommunity.text = @"";
            self.textBuild.text = @"";
            self.textFloor.text = @"";
            self.textRoom.text = @"";
            self.textOwnerName.text = @"";
        }
            break;
        case addSelectDistrict:{
            RegionInformation *region = [[[DistrictInformation instance] getDistricts:currentCity.regionId] objectAtIndex:indexPath.row];
            currentDistrict = region;
            textDisctrict.text = region.regionName;
            
            currentCommunity = nil;
            currentBuild = nil;
            currentFloor = nil;
            currentRoom = nil;
            
            self.textCommunity.text = @"";
            self.textBuild.text = @"";
            self.textFloor.text = @"";
            self.textRoom.text = @"";
            self.textOwnerName.text = @"";
        }
            break;
        case addSelectCommunity:{
            currentCommunity = [currentCommunityResponse.communities objectAtIndex:indexPath.row];
            textCommunity.text = currentCommunity.communityName;
            
            currentBuild = nil;
            currentFloor = nil;
            currentRoom = nil;
            
            self.textBuild.text = @"";
            self.textFloor.text = @"";
            self.textRoom.text = @"";
            self.textOwnerName.text = @"";
        }
            break;
        case addSelectBuild:{
            currentBuild = [currentRoomResponse.buildings objectAtIndex:indexPath.row];
            textBuild.text = currentBuild.buildNo;
            
            currentFloor = nil;
            currentRoom = nil;
            
            self.textFloor.text = @"";
            self.textRoom.text = @"";
            self.textOwnerName.text = @"";
        }
            break;
        case addSelectFloor:{
            currentFloor = [currentBuild.floors objectAtIndex:indexPath.row];
            textFloor.text = currentFloor.floorNo;
            
            currentRoom = nil;
            
            self.textRoom.text = @"";
            self.textOwnerName.text = @"";
        }
            break;
        case addSelectRoom:{
            currentRoom = [currentFloor.rooms objectAtIndex:indexPath.row];
            textRoom.text = currentRoom.roomNo;
            
            self.textOwnerName.text = @"";
        }
            break;
        default:
            break;
    }
    
    tableOptions.hidden = YES;
    self.viewMask.hidden = YES;
}

#pragma mark - Button Actions
- (IBAction)reset:(id)sender
{
    currentProvince = nil;
    currentCity = nil;
    currentDistrict = nil;
    
    currentCommunity = nil;
    currentRoomResponse = nil;
    
    currentBuild = nil;
    currentFloor = nil;
    currentRoom = nil;
    
    textProvince.text = @"";
    textCity.text = @"";
    textDisctrict.text = @"";
    textCommunity.text = @"";
    textBuild.text = @"";
    textFloor.text = @"";
    textRoom.text = @"";
}

- (IBAction)addBind:(id)sender
{
    [self sendBindCommunityRequest];
}

#pragma mark - Private Methods

- (void)sendBindCommunityRequest
{
    if(currentCommunity == nil){
        [self showErrorMessage:@"请选择一个小区"];
    }
    else if(currentBuild == nil){
        [self showErrorMessage:@"请选择楼栋"];
    }
    else if(currentFloor == nil){
        [self showErrorMessage:@"请选择层"];
    }
    else if(currentRoom == nil){
        [self showErrorMessage:@"请选择房间"];
    }
    else if([self.textOwnerName.text length] == 0){
        [self showErrorMessage:@"请输入业主姓名"];
    }
    else{
        currentSelection = addBind;
        BindCommunityRequestParameter *request = [[BindCommunityRequestParameter alloc] init];
        request.userId = [UserInformation instance].userId;
        request.password = [UserInformation instance].password;
        request.communityId = currentCommunity.communityId;
        request.buildNo = currentBuild.buildNo;
        request.floorNo = currentFloor.floorNo;
        request.roomNo = currentRoom.roomNo;
        request.ownerName = self.textOwnerName.text;
        
        [self resignFocus];
        [[CommunicationManager instance] bindCommunity:request withDelegate:self];
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
    self.viewMask.hidden = NO;
    tableOptions.hidden = NO;
    
    [tableOptions reloadData];
    float totalHeight = tableOptions.contentSize.height;
    float maxHeight = self.view.bounds.size.height - 5 * MIN_SELECTION_MARGIN;
    
    CGRect newFrame = tableOptions.frame;
    newFrame.size.height = MIN(totalHeight, maxHeight);
    tableOptions.frame = newFrame;
    tableOptions.center = self.view.center;
}

#pragma mark - Communication Delegate

- (void)ProcessServerResponse:(id)response
{
    if(currentSelection == addSelectCommunity){
        currentCommunityResponse = response;
        [self showSelectionTable];
    }
    else if(currentSelection == addSelectBuild){
        currentRoomResponse = response;
        [self showSelectionTable];
    }
    else if(currentSelection == addBind){
        [self.navigationController popViewControllerAnimated:YES];
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

#pragma mark - Keyborad

- (void)keyboardWillShow
{
    [UIView animateWithDuration:KEYBOARD_ANIMATE_TIME animations:^{
        constraint.constant = initialConst + keyboardHeight;
        [self.view layoutIfNeeded];
    }];
    
    UIScrollView *container = [CommonHelper getParentScrollView:self.textOwnerName];
    container.contentOffset = CGPointMake(0, [CommonHelper getRelatedOriginal:self.textOwnerName withParent:container].y - container.frame.size.height + self.textOwnerName.frame.size.height);
}


- (void)keyboardWillHide
{
    [UIView animateWithDuration:KEYBOARD_ANIMATE_TIME animations:^{
        constraint.constant = initialConst;
        [self.view layoutIfNeeded];
    }];
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
